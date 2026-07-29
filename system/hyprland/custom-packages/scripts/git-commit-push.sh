#!/usr/bin/env bash
set -euo pipefail

repo="${1:?Usage: $0 <repo-path>}"

log() { printf '%s %s\n' "$(date +'%Y-%m-%dT%H:%M:%S%z')" "$*" >&2; }
die() { log "ERROR: $*"; exit 1; }

cd "$repo" || die "cannot access to $repo"
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || die "$repo is not a git repository"

# Avoid concurrent runs
gitdir=$(git rev-parse --git-dir)
exec 9>"$gitdir/auto-sync.lock"
flock -n 9 || die "another run in progress"

branch=$(git symbolic-ref --short -q HEAD) || die "detached HEAD, doing nothing"

# 1. Commit all
if [ -n "$(git status --porcelain)" ]
then
    git add -A
    git commit -m "auto: $(date +'%Y-%m-%dT%H:%M:%S%z') on $(hostname -s)" \
        || die "commit failed"
    log "commit done on $branch"
fi

git fetch --quiet || die "git fetch has failed"

upstream="origin/$branch"

# 2. Pas d'upstream => premier push
if ! git rev-parse --verify --quiet "$upstream" >/dev/null
then
    git push -u origin "$branch" || die "first push failed"
    log "branche $branch pushed for the first time"
    exit 0
fi

# 3. Fetch remote and check for conflicts
if git rebase --quiet "$upstream"
then
    if git push --quiet; then
        log "synchronized with $upstream"
    else
        die "push refused"
    fi
else
    git rebase --abort
    safety="sync/conflit-$branch-$(date +%s)"

    git checkout -q -b "$safety"
    git branch -f "$branch" "$upstream"

    git push -u --quiet origin "$safety" \
        || die "cannot push the safety branch $safety"

    log "CONFLICT with $upstream : work has been stored on $safety (HEAD is now on it)"
    log "  $branch has been rebased on $upstream"
    exit 2
fi
