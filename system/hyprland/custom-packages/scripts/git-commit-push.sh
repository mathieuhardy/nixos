#!/usr/bin/env bash

set -euo pipefail

repo="${1:?Usage: $0 <chemin-du-repo>}"
cd "${repo}"

status=$(git status --porcelain)

if [ -n "${status}" ]
then
    ts=$(date +%s)
    git commit -a -m "${ts}" >/dev/null 2>&1
    git push
fi
