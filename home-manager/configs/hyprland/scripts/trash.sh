#!/usr/bin/env bash

TRASH_DIR="${HOME}/.local/share/Trash/files"

COUNT=0
if [ -d "${TRASH_DIR}" ]; then
    COUNT=$(ls -1 "${TRASH_DIR}" 2>/dev/null | wc -l)
fi

if [ "${COUNT}" -gt 0 ]; then
    TOOLTIP="${COUNT} items in trash"
    CLASS="not-empty"
    ICON="󰩹 ${COUNT}"
else
    TOOLTIP="Empty"
    CLASS="empty"
    ICON="󰩺"
fi

echo "{\"text\": \"${ICON}\", \"tooltip\": \"${TOOLTIP}\", \"class\": \"${CLASS}\"}"
