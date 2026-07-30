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
  gitwatch rofi_list ~/dev
}

list=$(build_list)
[ -z "${list}" ] && exit 1

chosen=$(printf '%s\n' "${list}" | rofi_cmd)
[ -z "${chosen}" ] && exit 0

name="${chosen#* }"
repo="${HOME}/dev/${name}"

gitwatch sync "${repo}"

pkill -RTMIN+8 waybar
