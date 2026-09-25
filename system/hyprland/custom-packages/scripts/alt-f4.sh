#!/usr/bin/env bash

if hyprctl activewindow -j | jq -e '.address' > /dev/null
then
    hyprctl dispatch killactive
else
    ~/.config/rofi/scripts/powermenu.sh
fi
