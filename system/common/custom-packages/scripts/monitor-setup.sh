#!/usr/bin/env bash

set -e

RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
NC="\033[0m"

# Laptop monitor
LAPTOP=$(hyprctl monitors all -j | jq -r '.[] | select(.name | startswith("eDP")) | .name')

# External monitor (first non-laptop)
EXTERNAL=$(hyprctl monitors -j | jq -r '.[] | select(.name | startswith("eDP") | not) | .name' | head -n1)

HAS_LAPTOP=true
HAS_EXTERNAL=false

if [[ -n "${LAPTOP}" ]]
then
    # Check the LID status
    state=$(cat /proc/acpi/button/lid/*/state)

    if echo "${state}" | grep -q closed
    then
        HAS_LAPTOP=false
    fi
else
    HAS_LAPTOP=false
fi

if [[ -n "${EXTERNAL}" ]]
then
    HAS_EXTERNAL=true
fi

if [[ "${HAS_LAPTOP}" = "true" ]]
then
    echo -e "${GREEN}✓ Laptop screen opened → enabling ${LAPTOP}${NC}"
    hyprctl keyword monitor "${LAPTOP},preferred,auto,1"

    # Move workspace 10 to laptop.
    # If this is the only monitor all workspaces will be on it already.
    echo -e "${BLUE}⮊ Move workspace 10 to ${LAPTOP}${NC}"
    hyprctl dispatch moveworkspacetomonitor 10 "${LAPTOP}"
else
    echo -e "${RED}✖ Laptop screen closed → disabling ${LAPTOP}${NC}"
    hyprctl keyword monitor "${LAPTOP},disable"
fi

if [[ "${HAS_EXTERNAL}" = "true" ]]
then
    echo -e "${GREEN}✓ External screen detected → ${EXTERNAL}${NC}"

    # Move workspaces to external except the 10.
    # In case the laptop is closed it will still be on this monitor.
    for ws in {1..9}
    do
        echo -e "${BLUE}⮊ Move workspace ${ws} to ${EXTERNAL}${NC}"
        hyprctl dispatch moveworkspacetomonitor "${ws}" "${EXTERNAL}"
    done

    if [[ "${HAS_LAPTOP}" = "false" ]]
    then
        echo -e "${BLUE}⮊ Move workspace 10 to ${EXTERNAL}${NC}"
        hyprctl dispatch moveworkspacetomonitor 10 "${EXTERNAL}"
    fi
fi
