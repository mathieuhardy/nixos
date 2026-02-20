#!/usr/bin/env bash

WS_COUNT=${1}
DIRECTION=${2}
CURRENT=$(hyprctl activeworkspace -j | jq '.id' )

if [ "${DIRECTION}" = "next" ]
then
    TARGET=$(( CURRENT + 1 ))
    [ ${TARGET} -gt ${WS_COUNT} ] && TARGET=1
    hyprctl dispatch workspace ${TARGET}
elif [ "${DIRECTION}" = "prev" ]
then
    TARGET=$(( CURRENT - 1 ))
    [ ${TARGET} -lt 1 ] && TARGET=${WS_COUNT}
    hyprctl dispatch workspace ${TARGET}
fi

