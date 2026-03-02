#!/usr/bin/env bash

COUNT=$(swaync-client -sw -c)

# TODO: return JSON (see trash-count.sh)
[ "${COUNT}" = "0" ] && echo "󰂚" || echo "󰂚 ${COUNT}"
