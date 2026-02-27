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
EXTERNAL=$(hyprctl monitors all -j | jq -r '.[] | select(.name | startswith("eDP") | not) | .name' | head -n1)

# wait_monitor() {
#   local name="${1}"
#
#   for i in {1..20}
#   do
#     if hyprctl monitors -j | jq -e ".[] | select(.name==\"${name}\")" >/dev/null
#     then
#       return 0
#     fi
#
#     sleep 0.1
#   done
#
#   echo -e "${RED}✖ Monitor $name never appeared${NC}"
#   return 1
# }

if [[ -n "${LAPTOP}" ]]
then
    # Check the LID status
    state=$(cat /proc/acpi/button/lid/*/state)

    if echo "${state}" | grep -q closed
    then
        echo -e "${RED}✖ Laptop screen closed → disabling ${LAPTOP}${NC}"

        hyprctl keyword monitor "${LAPTOP},disable"
    else
        # Ensure laptop monitor is enabled
        echo -e "${GREEN}✓ Laptop screen opened → enabling ${LAPTOP}${NC}"

        hyprctl keyword monitor "${LAPTOP},preferred,auto,1"
        # wait_monitor "${LAPTOP}"

        # Move workspace 10 to laptop.
        # If this is the only monitor all workspaces will be on it already.
        # echo -e "${BLUE}⮊ Move workspace 10 to ${LAPTOP}${NC}"
        #
        # hyprctl dispatch moveworkspacetomonitor 10 "${LAPTOP}" silent
    fi
fi

if [[ -n "${EXTERNAL}" ]]
then
    # Ensure external monitor is enabled
    echo -e "${GREEN}✓ External screen detected → enabling ${EXTERNAL}${NC}"

    hyprctl keyword monitor "${EXTERNAL},preferred,auto,1"
    # wait_monitor "${EXTERNAL}"

    # Move workspaces to external except the 10.
    # In case the laptop is closed it will still be on this monitor.
    # for ws in {1..9}
    # do
        # echo -e "${BLUE}⮊ Move workspace ${ws} to ${EXTERNAL}${NC}"

        # hyprctl dispatch moveworkspacetomonitor "${ws}" "${EXTERNAL}" silent
    # done
else
    # Ensure laptop monitor is enabled
    echo -e "${YELLOW}✖ No external → enabling ${LAPTOP}${NC}"

    hyprctl keyword monitor "${LAPTOP},preferred,auto,1"
    # wait_monitor "${LAPTOP}"

    # No external → everything on laptop.
    # If the laptop is closed, then workspaces are orphan.
    # for ws in {1..10}
    # do
        # echo -e "${BLUE}⮊ Move workspace ${ws} to ${LAPTOP}${NC}"

        # hyprctl dispatch moveworkspacetomonitor "${ws}" "${LAPTOP}" silent
    # done
fi





if [[ -n "${LAPTOP}" ]]
then
    # Check the LID status
    state=$(cat /proc/acpi/button/lid/*/state)

    if echo "${state}" | grep -q closed
    then
        echo -e "${RED}✖ Laptop screen closed → disabling ${LAPTOP}${NC}"
    else
        # Move workspace 10 to laptop.
        # If this is the only monitor all workspaces will be on it already.
        echo -e "${BLUE}⮊ Move workspace 10 to ${LAPTOP}${NC}"

        hyprctl dispatch moveworkspacetomonitor 10 "${LAPTOP}" silent
    fi
fi

if [[ -n "${EXTERNAL}" ]]
then
    # Move workspaces to external except the 10.
    # In case the laptop is closed it will still be on this monitor.
    for ws in {1..9}
    do
        echo -e "${BLUE}⮊ Move workspace ${ws} to ${EXTERNAL}${NC}"

        hyprctl dispatch moveworkspacetomonitor "${ws}" "${EXTERNAL}" silent
    done
else
    # No external → everything on laptop.
    # If the laptop is closed, then workspaces are orphan.
    for ws in {1..10}
    do
        echo -e "${BLUE}⮊ Move workspace ${ws} to ${LAPTOP}${NC}"

        hyprctl dispatch moveworkspacetomonitor "${ws}" "${LAPTOP}" silent
    done
fi
