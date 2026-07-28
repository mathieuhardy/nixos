#!/usr/bin/env bash

dir="${HOME}/.config/rofi/themes"
theme="gitmenu"
icon='●'

declare -A repo_path

rofi_cmd() {
	rofi -dmenu \
		-sync \
		-i \
		-p "Dirity repositories" \
		-theme ${dir}/${theme}.rasi
}

build_list() {
	for d in "${HOME}"/dev/*/
    do
		[ -d "${d}/.git" ] || continue
		[ -n "$(git -C "${d}" status --porcelain 2>/dev/null)" ] || continue

		name=$(basename "${d}")
		label="${icon} ${name}"
		repo_path["${label}"]="${d%/}"
		echo "${label}"
	done
}

list=$(build_list)
if [ -z "${list}" ]
then
	exit 0
fi

chosen=$(echo "${list}" | rofi_cmd)
[ -z "${chosen}" ] && exit 0

chosen=$(echo "${chosen}" | sed 's/'^"${icon}"' //g')
repo_path="${HOME}/dev/${chosen}"

git-commit-push "${repo_path}"

pkill -RTMIN+8 waybar
