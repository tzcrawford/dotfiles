import importlib.util
import io
import json
from pathlib import Path
import stat
import tempfile
import unittest
from unittest.mock import patch
import zipfile

spec = importlib.util.spec_from_file_location("installer", Path(__file__).resolve().with_name("install-skills.py"))
installer = importlib.util.module_from_spec(spec)
spec.loader.exec_module(installer)


def source():
    return {
        "repo": "example/skills", "revision": "a" * 40,
        "version": "1.0", "version_scope": "test", "license": "LICENSE",
        "skills": [{"id": name, "path": f"skills/{name}"} for name in ("alpha", "beta")],
    }


def archive(files=None):
    files = files or {
        "LICENSE": "MIT test license",
        "skills/alpha/SKILL.md": "alpha",
        "skills/alpha/references/notes.md": "reference",
        "skills/beta/SKILL.md": "beta",
        "skills/unwanted/SKILL.md": "not installed",
    }
    buffer = io.BytesIO()
    with zipfile.ZipFile(buffer, "w") as output:
        for name, content in files.items():
            output.writestr("repo-commit/" + name, content)
    return zipfile.ZipFile(io.BytesIO(buffer.getvalue()))


def tree(path):
    return {p.relative_to(path).as_posix(): p.read_bytes() for p in path.rglob("*") if p.is_file()}


class InstallerTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)
        self.dest = self.root / "skills"

    def install(self, sources=None):
        with patch.object(installer, "fetch_archive", side_effect=lambda _: archive()):
            installer.install(sources or [source()], self.dest)

    def test_full_install_references_license_receipt_and_idempotence(self):
        self.install()
        files = tree(self.dest)
        self.assertEqual(files["alpha/references/notes.md"], b"reference")
        self.assertIn("alpha/LICENSE", files)
        metadata = json.loads(files["alpha/.source.json"])
        self.assertEqual(metadata["revision"], "a" * 40)
        self.assertNotIn("unwanted/SKILL.md", files)
        self.install()
        self.assertEqual(tree(self.dest), files)

    def test_adopts_matching_unmanaged_subset_and_preserves_unrelated(self):
        (self.dest / "alpha").mkdir(parents=True)
        (self.dest / "alpha/SKILL.md").write_text("alpha")
        (self.dest / "mine").mkdir()
        (self.dest / "mine/SKILL.md").write_text("mine")
        self.install()
        self.assertEqual((self.dest / "mine/SKILL.md").read_text(), "mine")
        self.assertTrue((self.dest / "alpha/.source.json").exists())

    def test_rejects_unmanaged_changes(self):
        (self.dest / "alpha").mkdir(parents=True)
        (self.dest / "alpha/SKILL.md").write_text("my work")
        before = tree(self.dest)
        with self.assertRaisesRegex(ValueError, "Local/unmanaged"):
            self.install()
        self.assertEqual(tree(self.dest), before)

    def test_rejects_local_edits_deletions_and_added_files(self):
        for mutation in ("edit", "delete", "add"):
            with self.subTest(mutation=mutation):
                dest = self.root / mutation
                with patch.object(installer, "fetch_archive", side_effect=lambda _: archive()):
                    installer.install([source()], dest)
                    path = dest / "beta/SKILL.md"
                    if mutation == "edit":
                        path.write_text("edited")
                    elif mutation == "delete":
                        path.unlink()
                    else:
                        (dest / "beta/local.md").write_text("notes")
                    before = tree(dest)
                    with self.assertRaisesRegex(ValueError, "Local/unmanaged"):
                        installer.install([source()], dest)
                    self.assertEqual(tree(dest), before)

    def test_updates_clean_managed_install(self):
        self.install()
        updated = source()
        updated["revision"] = "b" * 40
        with patch.object(installer, "fetch_archive", side_effect=lambda _: archive({
            "LICENSE": "MIT test license", "skills/alpha/SKILL.md": "new alpha",
            "skills/beta/SKILL.md": "new beta",
        })):
            installer.install([updated], self.dest)
        self.assertEqual((self.dest / "alpha/SKILL.md").read_text(), "new alpha")
        self.assertFalse((self.dest / "alpha/references/notes.md").exists())

    def test_download_error_preserves_all_installs(self):
        self.install()
        before = tree(self.dest)
        with patch.object(installer, "fetch_archive", side_effect=[archive(), OSError("offline")]):
            with self.assertRaisesRegex(OSError, "offline"):
                installer.install([source(), source()], self.dest)
        self.assertEqual(tree(self.dest), before)

    def test_replacement_failure_rolls_back_batch(self):
        self.install()
        before = tree(self.dest)
        rename = Path.rename

        def fail_beta(path, target):
            if path.parent.name == "new" and path.name == "beta":
                raise OSError("simulated rename failure")
            return rename(path, target)

        with patch.object(Path, "rename", fail_beta):
            with self.assertRaisesRegex(OSError, "simulated"):
                self.install()
        self.assertEqual(tree(self.dest), before)

    def test_recheck_failure_rolls_back_completed_installs(self):
        self.install()
        before = tree(self.dest)
        check = installer.check_existing
        calls = 0

        def fail_recheck(path, desired):
            nonlocal calls
            calls += 1
            if calls == 4:
                raise ValueError("simulated concurrent edit")
            check(path, desired)

        with patch.object(installer, "check_existing", fail_recheck):
            with self.assertRaisesRegex(ValueError, "simulated"):
                self.install()
        self.assertEqual(tree(self.dest), before)

    def test_rejects_target_and_internal_symlinks(self):
        (self.root / "outside").mkdir()
        self.dest.mkdir()
        (self.dest / "alpha").symlink_to(self.root / "outside", target_is_directory=True)
        with self.assertRaisesRegex(ValueError, "symlink"):
            self.install()
        (self.dest / "alpha").unlink()
        (self.dest / "alpha").mkdir()
        (self.dest / "alpha/link").symlink_to(self.root / "outside", target_is_directory=True)
        with self.assertRaisesRegex(ValueError, "symlink"):
            self.install()

    def test_missing_skill_or_license_is_error(self):
        for files in ({"LICENSE": "MIT"}, {"skills/alpha/SKILL.md": "alpha"}):
            with archive(files) as bundle:
                with self.assertRaisesRegex(ValueError, "Missing"):
                    installer.skill_files(bundle, source(), source()["skills"][0])

    def test_rejects_archive_traversal(self):
        with archive({"LICENSE": "MIT", "skills/alpha/../../escape": "oops"}) as bundle:
            with self.assertRaisesRegex(ValueError, "Unsafe"):
                installer.skill_files(bundle, source(), source()["skills"][0])

    def test_rejects_archive_symlinks(self):
        buffer = io.BytesIO()
        with zipfile.ZipFile(buffer, "w") as output:
            entry = zipfile.ZipInfo("repo-commit/skills/alpha/link")
            entry.external_attr = (stat.S_IFLNK | 0o777) << 16
            output.writestr(entry, "/outside")
        with zipfile.ZipFile(io.BytesIO(buffer.getvalue())) as bundle:
            with self.assertRaisesRegex(ValueError, "regular file"):
                installer.skill_files(bundle, source(), source()["skills"][0])

    def test_rejects_malformed_and_duplicate_manifest_entries(self):
        for edit in ("sha", "path", "duplicate", "schema"):
            data = {"schema_version": 1, "sources": [source()]}
            if edit == "sha":
                data["sources"][0]["revision"] = "main"
            elif edit == "path":
                data["sources"][0]["skills"][0]["path"] = "../escape"
            elif edit == "duplicate":
                data["sources"][0]["skills"][1]["id"] = "alpha"
            else:
                data["schema_version"] = 2
            path = self.root / "manifest.json"
            path.write_text(json.dumps(data))
            with self.assertRaises(ValueError):
                installer.load_sources(path)

    def test_install_lock_refuses_concurrent_run(self):
        (self.dest / ".bootstrap.lock").mkdir(parents=True)
        with self.assertRaisesRegex(ValueError, "lock exists"):
            self.install()

    def test_invalid_receipt_refused_without_mutation(self):
        self.install()
        (self.dest / "alpha/.source.json").write_text("[]")
        before = tree(self.dest)
        with self.assertRaisesRegex(ValueError, "Local/unmanaged"):
            self.install()
        self.assertEqual(tree(self.dest), before)

    def test_keyboard_interrupt_rolls_back(self):
        self.install()
        before = tree(self.dest)
        rename = Path.rename

        def interrupt(path, target):
            if path.parent.name == "new" and path.name == "beta":
                raise KeyboardInterrupt()
            return rename(path, target)

        with patch.object(Path, "rename", interrupt):
            with self.assertRaises(KeyboardInterrupt):
                self.install()
        self.assertEqual(tree(self.dest), before)

    def test_failed_rollback_preserves_original_backup(self):
        self.install()
        rename = Path.rename

        def fail(path, target):
            if path.name == "beta" and (path.parent.name == "new" or path.parent.name.startswith(".bootstrap-recovery-")):
                raise OSError("simulated replacement and recovery failure")
            return rename(path, target)

        with patch.object(Path, "rename", fail):
            with self.assertRaisesRegex(OSError, "simulated"):
                self.install()
        backups = list(self.dest.glob(".bootstrap-recovery-*/beta/SKILL.md"))
        self.assertEqual(len(backups), 1)
        self.assertEqual(backups[0].read_text(), "beta")

    def test_concurrent_edits_survive_rollback(self):
        self.install()
        check = installer.check_existing
        calls = 0

        def edit_and_fail(path, desired):
            nonlocal calls
            calls += 1
            if calls == 4:
                (self.dest / "alpha/SKILL.md").write_text("concurrent edit")
                raise ValueError("simulated concurrent edit")
            check(path, desired)

        with patch.object(installer, "check_existing", edit_and_fail):
            with self.assertRaisesRegex(ValueError, "simulated"):
                self.install()
        self.assertEqual((self.dest / "alpha/SKILL.md").read_text(), "concurrent edit")
        backups = list(self.dest.glob(".bootstrap-recovery-*/alpha/SKILL.md"))
        self.assertEqual(len(backups), 1)
        self.assertEqual(backups[0].read_text(), "alpha")

    def test_unexpected_empty_directory_is_preserved(self):
        self.install()
        (self.dest / "alpha/my-drafts").mkdir()
        with self.assertRaisesRegex(ValueError, "empty directories"):
            self.install()
        self.assertTrue((self.dest / "alpha/my-drafts").is_dir())


if __name__ == "__main__":
    unittest.main()
