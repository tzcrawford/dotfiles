#!/bin/bash
# Claude Code PostToolUse hook: mark Claude's commits with a git note, so
# attribution stays out of the commit message. Never fails the tool call.
input=$(cat)
cmd=$(jq -r '.tool_input.command // empty' <<<"$input" 2>/dev/null)
cwd=$(jq -r '.cwd // empty' <<<"$input" 2>/dev/null)
[ -n "$cwd" ] || cwd=$PWD

# Find the repo the commit ran in: `git -C <path> commit`, then the last
# `cd <path>` before the commit, then the hook's working directory.
target=$cwd
path='("[^"]+"|'"'"'[^'"'"']+'"'"'|[^[:space:];&|]+)'
if [[ $cmd =~ git[[:space:]]+-C[[:space:]]+$path[[:space:]]+commit ]]; then
  target=${BASH_REMATCH[1]}
else
  before_commit=${cmd%%git commit*}
  while [[ $before_commit =~ (^|[;&|[:space:]])cd[[:space:]]+$path(.*)$ ]]; do
    target=${BASH_REMATCH[2]}
    before_commit=${BASH_REMATCH[3]}
  done
fi
target=${target%\"}; target=${target#\"}
target=${target%\'}; target=${target#\'}
[[ $target = /* ]] || target=$cwd/$target
[ -d "$target" ] || target=$cwd

# Skip anything that matched the hook but didn't just create a commit.
committed=$(git -C "$target" log -1 --format=%ct HEAD 2>/dev/null) || exit 0
[ $(($(date +%s) - committed)) -le 60 ] || exit 0

git -C "$target" notes --ref=claude add -m 'Assisted-by: Claude Code' HEAD 2>/dev/null
exit 0
