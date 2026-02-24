#!/usr/bin/env bash

BATTERY_PATH="/sys/class/power_supply/BAT0"
NOTIFIED_40=false
NOTIFIED_10=false
NOTIFIED_5=false

while true
do
  CAPACITY=$(cat "${BATTERY_PATH}/capacity")
  STATUS=$(cat "${BATTERY_PATH}/status")

  if [[ "${STATUS}" != "Charging" && "${STATUS}" != "Full" ]]
  then
    if [[ ${CAPACITY} -le 5 && "${NOTIFIED_5}" == false ]]
    then
      notify-send \
        -u critical \
        -i battery-caution \
        "🔋 Critical battery" \
        "Level : ${CAPACITY}% — Plug immediately !" \
        -t 0  # show forever

      NOTIFIED_5=true
      NOTIFIED_10=true
    elif [[ ${CAPACITY} -le 10 && "${NOTIFIED_10}" == false ]]
    then
      notify-send \
        -u critical \
        -i battery-low \
        "🔋 Very low battery" \
        "Level: ${CAPACITY}% — Plug the charger." \
        -t 10000 # 10 seconds

      NOTIFIED_10=true
    elif [[ ${CAPACITY} -le 40 && "${NOTIFIED_40}" == false ]]
    then
      notify-send \
        -u normal \
        -i battery-low \
        "🔋 Low battery" \
        "Level: ${CAPACITY}% — Plug the charger." \
        -t 10000 # 10 seconds

      NOTIFIED_40=true
    fi
  else
    # Reset when charging or full
    NOTIFIED_40=false
    NOTIFIED_10=false
    NOTIFIED_5=false
  fi

  sleep 60
done
