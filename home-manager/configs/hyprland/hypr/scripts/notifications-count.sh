#!/usr/bin/env bash

COUNT=$(swaync-client -c)

[ "${COUNT}" = "0" ] && echo "󰂚" || echo "󰂚 ${COUNT}"
