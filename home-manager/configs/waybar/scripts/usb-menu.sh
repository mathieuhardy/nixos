#!/usr/bin/env bash
# Rofi menu to eject USB drives mounted under /run/media/USER.
# Skips the encrypted data card. Signals waybar to refresh after eject.

IGNORED_UUID="e7f34150-ee9b-45de-8dca-391761a45c6d"
MEDIA_PATH="/run/media/$(whoami)"

mapfile -t targets < <(
  findmnt -J --list --real -o TARGET,SOURCE 2>/dev/null \
  | jq -r ".filesystems[] \
    | select(.target | startswith(\"$MEDIA_PATH\")) \
    | select(.source | contains(\"$IGNORED_UUID\") | not) \
    | .target" 2>/dev/null
)

[ ${#targets[@]} -eq 0 ] && exit 0

names=()
for t in "${targets[@]}"; do
  names+=("$(basename "$t")")
done

selected=$(printf '%s\n' "${names[@]}" | rofi -dmenu -p "󰏛 Éjecter")
[ -z "$selected" ] && exit 0

for i in "${!names[@]}"; do
  if [ "${names[$i]}" = "$selected" ]; then
    udiskie-umount "${targets[$i]}"
    pkill -RTMIN+7 waybar
    break
  fi
done
