# Downloaded OpenCode skills

Track `install-skills.py`, `skills-lock.json`, `test_install_skills.py`, and this file in dotfiles. Python
3.9+ and HTTPS access to GitHub are the only requirements; no Claude Code, GitHub
CLI, npm installer, or API token is needed.

```sh
python3 "${XDG_CONFIG_HOME:-$HOME/.config}/opencode/install-skills.py" --list
python3 "${XDG_CONFIG_HOME:-$HOME/.config}/opencode/install-skills.py"
python3 -B "${XDG_CONFIG_HOME:-$HOME/.config}/opencode/test_install_skills.py"
```

The default destination is `${XDG_CONFIG_HOME:-~/.config}/opencode/skills`.
Use `--dest /some/path/skills` to test elsewhere, or `--manifest /path/to/skills-lock.json`
to use another manifest. Paths are independent of the working directory.
OpenCode discovers its native global skills directory automatically; use `/reload`
if a newly installed skill is not immediately available.

## Pins

Exact upstream commit SHAs and source paths are in `skills-lock.json`. The
versions recorded at setup are:

| Skill | Version label |
| --- | --- |
| `qmd` | QMD package 2.8.3; skill metadata 2.3.0 |
| `improve` | Skill/plugin 1.0.0 |
| `thermo-nuclear-code-quality-review` | Cursor Team Kit plugin 1.2.0 |
| `improve-codebase-architecture` | Matt Pocock skills package 1.3.2 |
| `codebase-design`, `grilling`, `domain-modeling` | Same Matt Pocock pin; required by the architecture skill |

Package/plugin versions are not necessarily individual skill versions. Commit
SHAs identify the exact installed source. Each installed directory contains
supporting files, a license, and `.source.json` with its provenance and file hashes.
Upstream skill content is not rewritten. Cursor's review skill and Matt's
architecture skill deliberately disable automatic invocation; explicitly request
their skill IDs when you want to use them.

## Git ignores

Add these entries to the `.gitignore` governing your OpenCode config directory
(adjust the prefixes if that directory is nested in your dotfiles repository):

```gitignore
/skills/qmd/
/skills/improve/
/skills/thermo-nuclear-code-quality-review/
/skills/improve-codebase-architecture/
/skills/codebase-design/
/skills/grilling/
/skills/domain-modeling/
/skills/.bootstrap-*/
/skills/.bootstrap.lock/
```

Alternatively, ignore `/skills/` if all of your global skills are downloaded.
Already tracked skill files need to be untracked separately; adding an ignore
rule alone does not untrack them.

## Reinstalling and updating

Re-running downloads the same pinned sources, not whatever happens to be on
`main`. To upgrade, inspect the upstream changes, update each affected `revision`
and version label in `skills-lock.json`, check that source paths and sibling-skill
dependencies still exist, then run the script again. Version labels are descriptive
metadata, not a mechanism for choosing a Git revision.

Downloads are staged before replacement, and unrelated skill directories are
untouched. The installer refuses locally edited installs and symlinked skill
directories. Back up and move a modified directory aside yourself before
reinstalling; there is no destructive force option. The original QMD snapshot can
be adopted when all of its existing files match the pinned upstream copy.

If rollback cannot finish (for example, because a directory was edited during
installation), recovery copies remain under `skills/.bootstrap-recovery-*`, and
the script reports their location. Do not delete those copies until you have
recovered your files. A machine crash or forced kill can also leave recovery
copies and a stale lock; inspect both before reinstalling.

Upstream code is only downloaded, never executed by the installer. The installed
skills themselves contain instructions that may request code edits, subagents,
external services, or GitHub issues when later invoked; normal agent permissions
and project instructions still apply. QMD's CLI and search indexes are separate
and are not installed or changed by this script.
