#!/usr/bin/env bash

COUNT=$(swaync-client -sw -c)

[ "${COUNT}" = "0" ] && echo "󰂚" || echo "󰂚 ${COUNT}"
