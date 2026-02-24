#!/usr/bin/env bash

set -e

LAPTOP="eDP-1"
EXTERNAL="DP-2"

# Try to find laptop monitor
if hyprctl monitors | grep -q "${LAPTOP}"
then
    LAPTOP_PRESENT=true
else
    LAPTOP_PRESENT=false
fi

# Apply rules
if ${LAPTOP_PRESENT}
then
    echo "Laptop screen detected → enabling ${LAPTOP}"

    # Ensure laptop monitor is enabled
    hyprctl keyword monitor "${LAPTOP},preferred,auto,1"

    # Move workspace 10 to laptop
    hyprctl dispatch moveworkspacetomonitor 10 "${LAPTOP}"

    # Ensure other workspaces stay on external
    for ws in {1..9}
    do
        hyprctl dispatch moveworkspacetomonitor "${ws}" "${EXTERNAL}"
    done
else
    echo "Laptop screen not detected → disabling ${LAPTOP}"

    # Move all workspaces back to external
    for ws in {1..10}
    do
        hyprctl dispatch moveworkspacetomonitor "${ws}" "${EXTERNAL}"
    done

    # Disable laptop monitor
    hyprctl keyword monitor "${LAPTOP},disable"
fi
