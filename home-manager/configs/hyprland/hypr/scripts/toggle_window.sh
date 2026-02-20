#!/usr/bin/env bash

ACTION="${1}"
APP_CLASS="${2}"
APP_CMD="${3}"

EXISTS=$(hyprctl clients -j | jq -r ".[] | select(.class == \"${APP_CLASS}\") | .address")
WORKSPACE=$(hyprctl clients -j | jq -r ".[] | select(.class == \"${APP_CLASS}\") | .workspace.name")
ACTIVE_CLASS=$(hyprctl activewindow -j | jq -r ".class")

if [ "${ACTION}" = "toggle" ]
then
  if [ -z "${EXISTS}" ]
  then
    # Application doesn't exist: launch it
    ${APP_CMD} &
  elif [ "${WORKSPACE}" = "special:hidden" ]
  then
    # Application is hidden: show
    hyprctl dispatch movetoworkspace "e+0,class:(${APP_CLASS})"
  else
    # Application exists but is not hidden: hide
    hyprctl dispatch movetoworkspacesilent "special:hidden,class:(${APP_CLASS})"
  fi
elif [ "${ACTION}" = "hide" ] && [ "${ACTIVE_CLASS}" = "${APP_CLASS}" ]
then
    # Application is active: hide
    hyprctl dispatch movetoworkspacesilent "special:hidden,class:(${APP_CLASS})"
fi
