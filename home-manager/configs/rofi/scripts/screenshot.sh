#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Screenshot

theme_dir="${HOME}/.config/rofi/themes"
theme="screenshot"

prompt='Screenshot'
output_dir="`xdg-user-dir PICTURES`/Screenshots"
mesg="Output: ${output_dir}"

option_1=$'󰍹\tCapture Desktop'
option_2=$'󰒉\tCapture Area'
option_3=$'󰨇\tCapture Window'
option_4=$'\tCapture in 5s'
option_5=$'\tCapture in 10s'

rofi_cmd() {
	rofi -theme-str "window {width: 400px;}" \
		-theme-str "listview {columns: 1; lines: 5;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "${prompt}" \
		-mesg "${mesg}" \
		-markup-rows \
		-theme ${theme_dir}/${theme}.rasi
}

run_rofi() {
	echo -e "${option_1}\n${option_2}\n${option_3}\n${option_4}\n${option_5}" | rofi_cmd
}

shotnow () {
	hyprshot -o ${output_dir} -m output -m active
}

shotwin () {
	hyprshot -o ${output_dir} -m window
}

shotarea () {
	hyprshot -o ${output_dir} -m region
}

shot5 () {
	sleep 5
	shotnow
}

shot10 () {
    sleep 10
    shotnow
}

run_cmd() {
	if [[ "$1" == '--opt1' ]]
    then
		shotnow
	elif [[ "$1" == '--opt2' ]]
    then
		shotarea
	elif [[ "$1" == '--opt3' ]]
    then
		shotwin
	elif [[ "$1" == '--opt4' ]]
    then
		shot5
	elif [[ "$1" == '--opt5' ]]
    then
		shot10
	fi
}

if [[ ! -d "${output_dir}" ]]
then
	mkdir -p "${output_dir}"
fi

chosen=$(run_rofi)

case "${chosen}" in
    ${option_1})
		run_cmd --opt1
        ;;
    ${option_2})
		run_cmd --opt2
        ;;
    ${option_3})
		run_cmd --opt3
        ;;
    ${option_4})
		run_cmd --opt4
        ;;
    ${option_5})
		run_cmd --opt5
        ;;
esac
