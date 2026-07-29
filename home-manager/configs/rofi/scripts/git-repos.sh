#!/usr/bin/env bash

dir="${HOME}/.config/rofi/themes"
theme="gitmenu"
icon_dirty='●'
icon_clean='○'

rofi_cmd() {
	rofi -dmenu \
		-sync \
		-i \
		-p "Repos" \
		-theme "${dir}/${theme}.rasi"
}

build_list() {
	local dirty=() clean=()

	for d in "${HOME}"/dev/*/
    do
        [ -d "${d}.git" ] || continue

        name=$(basename "$d")

        if [ -n "$(git -C "$d" status --porcelain 2>/dev/null)" ]
        then
            dirty+=("${icon_dirty} ${name}")
        else
            clean+=("${icon_clean} ${name}")
        fi
	done

	printf '%s\n' "${dirty[@]}" "${clean[@]}"
}

list=$(build_list)
[ -z "${list}" ] && exit 1

chosen=$(printf '%s\n' "${list}" | rofi_cmd)
[ -z "${chosen}" ] && exit 0

name="${chosen#* }"
repo="${HOME}/dev/${name}"

git-commit-push "${repo}"

pkill -RTMIN+8 waybar
