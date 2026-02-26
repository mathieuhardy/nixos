#!/usr/bin/env bash

set -e

# Laptop monitor
LAPTOP=$(hyprctl monitors -j | jq -r '.[] | select(.name | startswith("eDP")) | .name')

# External monitor (first non-laptop)
EXTERNAL=$(hyprctl monitors -j | jq -r '.[] | select(.name | startswith("eDP") | not) | .name' | head -n1)

if [[ -n "${LAPTOP}" ]]
then
    # Ensure laptop monitor is enabled
    echo "Laptop screen detected → enabling ${LAPTOP}"

    hyprctl keyword monitor "${LAPTOP},preferred,auto,1"

    # Move workspace 10 to laptop.
    # If this is the only monitor all workspaces will be on it already.
    echo "Move workspace 10 to ${LAPTOP}"

    hyprctl dispatch moveworkspacetomonitor 10 "${LAPTOP}" silent
fi

if [[ -n "${EXTERNAL}" ]]
then
    # Ensure external monitor is enabled
    echo "External screen detected → enabling ${EXTERNAL}"

    hyprctl keyword monitor "${EXTERNAL},preferred,auto,1"

    # Move workspaces to external except the 10.
    # In case the laptop is closed it will still be on this monitor.
    for ws in {1..9}
    do
        echo "Move workspace ${ws} to ${EXTERNAL}"

        hyprctl dispatch moveworkspacetomonitor "${ws}" "${EXTERNAL}" silent
    done
else
    # Ensure laptop monitor is enabled
    echo "No external → enabling ${LAPTOP}"

    hyprctl keyword monitor "${LAPTOP},preferred,auto,1"

    # No external → everything on laptop.
    # If the laptop is closed, then workspaces are orphan.
    for ws in {1..10}
    do
        echo "Move workspace ${ws} to ${LAPTOP}"

        hyprctl dispatch moveworkspacetomonitor "${ws}" "${LAPTOP}" silent
    done
fi
