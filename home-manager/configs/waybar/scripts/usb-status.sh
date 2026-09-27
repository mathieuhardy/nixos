#!/usr/bin/env bash
# Outputs JSON for the waybar custom/usb module.
# Lists drives mounted under /run/media/USER, skipping the encrypted data card.

IGNORED_UUID="e7f34150-ee9b-45de-8dca-391761a45c6d"
MEDIA_PATH="/run/media/$(whoami)"

mapfile -t targets < <(
  findmnt -J --list --real -o TARGET,SOURCE 2>/dev/null \
  | jq -r ".filesystems[] \
    | select(.target | startswith(\"$MEDIA_PATH\")) \
    | select(.source | contains(\"$IGNORED_UUID\") | not) \
    | .target" 2>/dev/null
)

count=${#targets[@]}

if [ "$count" -eq 0 ]; then
  echo '{"text": "", "tooltip": "", "class": "empty"}'
else
  names=()
  for t in "${targets[@]}"; do
    names+=("$(basename "$t")")
  done
  tooltip=$(printf '%s\n' "${names[@]}")
  jq -n \
    --arg text "󰉁 $count" \
    --arg tooltip "$tooltip" \
    --arg class "active" \
    '{text: $text, tooltip: $tooltip, class: $class}'
fi
