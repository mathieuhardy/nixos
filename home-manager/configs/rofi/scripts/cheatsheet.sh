#!/usr/bin/env bash

DIR="$HOME/.config/rofi/data/cheatsheet"
THEME=${HOME}/.config/rofi/themes/cheatsheet.rasi

# "⚡ Commandes"
# "❌ Quitter"
choice=$(printf '%s\n' \
    "⌨  Keybinds" \
    "📦 Applications" | \
    rofi -dmenu \
         -i \
         -p "Cheatsheet" \
         -theme ${THEME})

case "$choice" in
    "⌨  Keybinds")
        cat "$DIR/keybinds.txt" |
            grep -v '^#' |
            sed '/^[[:space:]]*$/d' |
            rofi -dmenu -i -p "Keybinds" -theme ${THEME}
        ;;

    "📦 Applications")
        cat "$DIR/applications.txt" |
            grep -v '^#' |
            sed '/^[[:space:]]*$/d' |
            rofi -dmenu -i -p "Applications" -theme ${THEME}
        ;;
esac
