#!/usr/bin/env python3
"""Restore pinned OpenCode skills. Requires Python 3.9+; runs no upstream code."""

import argparse
import hashlib
import io
import json
import os
from pathlib import Path, PurePosixPath
import re
import shutil
import stat
import sys
import tempfile
from urllib.request import urlopen
import zipfile


RECEIPT = ".source.json"
MAX_ARCHIVE = 64 * 1024 * 1024
MAX_SKILL = 8 * 1024 * 1024


def safe_path(value):
    if (not isinstance(value, str) or not value or "\\" in value
            or value.startswith("/") or any(p in ("", ".", "..") for p in value.split("/"))):
        raise ValueError(f"Unsafe relative path: {value!r}")
    return PurePosixPath(value)


def load_sources(path):
    manifest = json.loads(path.read_text())
    if not isinstance(manifest, dict) or manifest.get("schema_version") != 1 or not manifest.get("sources"):
        raise ValueError("Expected schema_version 1 and nonempty sources in manifest")
    seen = set()
    for source in manifest["sources"]:
        if not re.fullmatch(r"[\w.-]+/[\w.-]+", source["repo"], flags=re.ASCII):
            raise ValueError(f"Invalid GitHub repo: {source['repo']!r}")
        if not re.fullmatch(r"[0-9a-f]{40}", source["revision"]):
            raise ValueError("Every source must pin a full 40-character commit SHA")
        safe_path(source["license"])
        if not source.get("skills") or not source.get("version") or not source.get("version_scope"):
            raise ValueError("Every source needs skills, version, and version_scope")
        for skill in source["skills"]:
            name = skill["id"]
            if not re.fullmatch(r"[a-z0-9]+(?:-[a-z0-9]+)*", name) or name in seen:
                raise ValueError(f"Invalid or duplicate skill ID: {name!r}")
            seen.add(name)
            safe_path(skill["path"])
    return manifest["sources"]


def fetch_archive(source):
    url = f"https://codeload.github.com/{source['repo']}/zip/{source['revision']}"
    with urlopen(url, timeout=60) as response:
        data = response.read(MAX_ARCHIVE + 1)
    if len(data) > MAX_ARCHIVE:
        raise ValueError(f"Archive exceeds 64 MiB: {source['repo']}")
    return zipfile.ZipFile(io.BytesIO(data))


def skill_files(archive, source, skill):
    files = {}
    total = 0
    prefix = skill["path"] + "/"
    for entry in archive.infolist():
        if entry.is_dir():
            continue
        _, separator, path = entry.filename.partition("/")
        if not separator or not (path.startswith(prefix) or path == source["license"]):
            continue
        safe_path(path)
        if stat.S_IFMT(entry.external_attr >> 16) not in (0, stat.S_IFREG):
            raise ValueError(f"Not a regular file in archive: {path}")
        name = path[len(prefix):] if path.startswith(prefix) else "LICENSE"
        safe_path(name)
        total += entry.file_size
        if total > MAX_SKILL or name == RECEIPT or name in files:
            raise ValueError(f"Oversized skill or conflicting file: {skill['id']}/{name}")
        files[name] = archive.read(entry)
    if "SKILL.md" not in files or "LICENSE" not in files:
        raise ValueError(f"Missing SKILL.md or license for {skill['id']}")
    return files


def hashes(files):
    return {name: hashlib.sha256(data).hexdigest() for name, data in sorted(files.items())}


def read_files(target):
    if target.is_symlink():
        raise ValueError(f"Refusing symlinked skill: {target}")
    if not target.exists():
        return {}
    if not target.is_dir():
        raise ValueError(f"Not a skill directory: {target}")
    current = {}
    directories = set()
    for path in target.rglob("*"):
        if path.is_symlink():
            raise ValueError(f"Refusing symlink inside skill: {path}")
        if path.is_file():
            current[path.relative_to(target).as_posix()] = path.read_bytes()
        elif path.is_dir():
            directories.add(path.relative_to(target).as_posix())
        else:
            raise ValueError(f"Not a regular file: {path}")
    expected_dirs = {parent.as_posix() for name in current
                     for parent in PurePosixPath(name).parents if parent != PurePosixPath(".")}
    if directories - expected_dirs:
        raise ValueError(f"Unexpected empty directories in {target}; back them up and move them aside first")
    return current


def check_existing(target, desired):
    """Only replace clean managed installs, or exact subsets of the desired files."""
    current = read_files(target)
    receipt = current.pop(RECEIPT, None)
    if receipt is not None:
        metadata = json.loads(receipt)
        clean = isinstance(metadata, dict) and hashes(current) == metadata.get("files")
    else:
        clean = all(desired.get(name) == data for name, data in current.items())
    if not clean:
        raise ValueError(f"Local/unmanaged changes in {target}; back them up and move the directory aside first")


def install(sources, destination):
    destination.mkdir(parents=True, exist_ok=True)
    lock = destination / ".bootstrap.lock"
    try:
        lock.mkdir()
    except FileExistsError:
        raise ValueError(f"Install lock exists: {lock}. If no installer is running, remove this empty directory.") from None
    try:
        with tempfile.TemporaryDirectory(prefix=".bootstrap-", dir=destination) as temporary:
            staging = Path(temporary)
            planned = []
            for source in sources:
                print(f"Fetching {source['repo']} {source['version']} @ {source['revision']}", flush=True)
                with fetch_archive(source) as archive:
                    for skill in source["skills"]:
                        name = skill["id"]
                        files = skill_files(archive, source, skill)
                        receipt = {key: source[key] for key in ("repo", "revision", "version", "version_scope")}
                        receipt.update(path=skill["path"], files=hashes(files))
                        files[RECEIPT] = (json.dumps(receipt, indent=2, sort_keys=True) + "\n").encode()
                        target = destination / name
                        check_existing(target, files)
                        folder = staging / "new" / name
                        for relative, data in files.items():
                            output = folder / relative
                            output.parent.mkdir(parents=True, exist_ok=True)
                            output.write_bytes(data)
                        planned.append((name, files))
            # No existing install changes until every download and validation succeeds.
            # Recovery copies live OUTSIDE auto-cleaned staging, so an interrupted
            # or failed rollback cannot delete the user's original directories.
            backups = Path(tempfile.mkdtemp(prefix=".bootstrap-recovery-", dir=destination))
            attempted = []
            try:
                for name, files in planned:
                    target = destination / name
                    check_existing(target, files)
                    attempted.append((name, files))
                    backup = backups / name
                    if target.exists():
                        target.rename(backup)
                    (staging / "new" / name).rename(target)
            except BaseException:
                recovery_errors = []
                for name, files in reversed(attempted):
                    target = destination / name
                    try:
                        if not (staging / "new" / name).exists():
                            if read_files(target) != files:
                                raise ValueError(f"Concurrent changes in {target}; leaving them untouched")
                            shutil.rmtree(target)
                        if (backups / name).exists():
                            (backups / name).rename(target)
                    except (OSError, ValueError) as error:
                        recovery_errors.append(str(error))
                if recovery_errors:
                    print(f"Recovery incomplete. Originals retained in {backups}:\n" + "\n".join(recovery_errors), file=sys.stderr)
                else:
                    backups.rmdir()
                raise
            else:
                shutil.rmtree(backups)
            for name, _ in planned:
                print(f"Installed {destination / name}")
    finally:
        lock.rmdir()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", type=Path, default=Path(__file__).resolve().with_name("skills-lock.json"))
    config = Path(os.environ.get("XDG_CONFIG_HOME", "") or Path.home() / ".config")
    parser.add_argument("--dest", type=Path, default=config / "opencode/skills")
    parser.add_argument("--list", action="store_true", help="Show pins without downloading or modifying anything")
    args = parser.parse_args()
    try:
        sources = load_sources(args.manifest.expanduser())
        if args.list:
            for source in sources:
                for skill in source["skills"]:
                    print(f"{skill['id']}: {source['version']} ({source['version_scope']}); {source['repo']}@{source['revision']}")
        else:
            install(sources, args.dest.expanduser())
    except (OSError, ValueError, KeyError, TypeError, zipfile.BadZipFile) as error:
        print(f"Error: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
