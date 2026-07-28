#!/usr/bin/env bash

dirty=0
git_icon=""

for d in ~/dev/*/
do
    [ -d "${d}/.git" ] || continue
    [ -n "$(git -C "${d}" status --porcelain 2>/dev/null)" ] && dirty=$((dirty + 1))
done

if [ "$dirty" -gt 0 ]
then
    echo "{\"text\":\"${git_icon} ${dirty}\",\"class\":\"dirty\",\"tooltip\":\"${dirty} repo(s) dirty\"}"
else
    echo "{\"text\":\"${git_icon} ✔\",\"class\":\"clean\",\"tooltip\":\"All repos are clean\"}"
fi
