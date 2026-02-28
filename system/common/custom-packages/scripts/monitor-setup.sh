#!/usr/bin/env bash

set -e

RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
NC="\033[0m"

# Active workspace
ACTIVE_WS=$(hyprctl activeworkspace -j | jq '.id')

# Internal monitor
INTERNAL=$(hyprctl monitors all -j | jq -r '.[] | select(.name | startswith("eDP")) | .name')

# External monitor (first non-internal)
EXTERNAL=$(hyprctl monitors -j | jq -r '.[] | select(.name | startswith("eDP") | not) | .name' | head -n1)

HAS_INTERNAL=true
HAS_EXTERNAL=false

if [[ -n "${INTERNAL}" ]]
then
    # Check the LID status
    state=$(cat /proc/acpi/button/lid/*/state)

    if echo "${state}" | grep -q closed
    then
        HAS_INTERNAL=false
    fi
else
    HAS_INTERNAL=false
fi

if [[ -n "${EXTERNAL}" ]]
then
    HAS_EXTERNAL=true
fi

# Handle profiles
if [[ "${HAS_INTERNAL}" = "true" ]] && [[ "${HAS_EXTERNAL}" = "false" ]]
then
    # Assign all workspaces to internal
    echo -e "${BLUE}⮊ Move workspace 1 to ${INTERNAL} (as default)${NC}"
    hyprctl keyword workspace "1,monitor:${INTERNAL},persistent:true,default:true"
    hyprctl dispatch moveworkspacetomonitor 1 "${INTERNAL}"

    for ws in {2..10}
    do
        echo -e "${BLUE}⮊ Move workspace ${ws} to ${INTERNAL}${NC}"
        hyprctl keyword workspace "${ws},monitor:${INTERNAL},persistent:true"
        hyprctl dispatch moveworkspacetomonitor "${ws}" "${INTERNAL}"
    done

    echo -e "${GREEN}✓ Enabling internal: ${INTERNAL}${NC}"
    hyprctl keyword monitor "${INTERNAL},preferred,auto,1"
elif [[ "${HAS_INTERNAL}" = "false" ]] && [[ "${HAS_EXTERNAL}" = "true" ]]
then
    # Assign all workspaces to external
    echo -e "${BLUE}⮊ Move workspace 1 to ${EXTERNAL} (as default)${NC}"
    hyprctl keyword workspace "1,monitor:${EXTERNAL},persistent:true,default:true"
    hyprctl dispatch moveworkspacetomonitor 1 "${EXTERNAL}"

    for ws in {2..10}
    do
        echo -e "${BLUE}⮊ Move workspace ${ws} to ${EXTERNAL}${NC}"
        hyprctl keyword workspace "${ws},monitor:${EXTERNAL},persistent:true"
        hyprctl dispatch moveworkspacetomonitor "${ws}" "${EXTERNAL}"
    done

    echo -e "${RED}✖ Disabling internal: ${INTERNAL}${NC}"
    hyprctl keyword monitor "${INTERNAL},disable"
elif [[ "${HAS_INTERNAL}" = "true" ]] && [[ "${HAS_EXTERNAL}" = "true" ]]
then
    # Workspace 10 to internal
    echo -e "${BLUE}⮊ Move workspace 10 to ${INTERNAL} (as default)${NC}"
    hyprctl keyword workspace "10,monitor:${INTERNAL},persistent:true,default:true"
    hyprctl dispatch moveworkspacetomonitor 10 "${INTERNAL}"

    echo -e "${GREEN}✓ Enabling internal: ${INTERNAL}${NC}"
    hyprctl keyword monitor "${INTERNAL},preferred,auto,1"

    # The rest to external
    echo -e "${BLUE}⮊ Move workspace 1 to ${EXTERNAL} (as default)${NC}"
    hyprctl keyword workspace "1,monitor:${EXTERNAL},persistent:true,default:true"
    hyprctl dispatch moveworkspacetomonitor 1 "${EXTERNAL}"

    for ws in {2..9}
    do
        echo -e "${BLUE}⮊ Move workspace ${ws} to ${EXTERNAL}${NC}"
        hyprctl keyword workspace "${ws},monitor:${EXTERNAL},persistent:true"
        hyprctl dispatch moveworkspacetomonitor "${ws}" "${EXTERNAL}"
    done
fi

# Jump back to active
hyprctl dispatch workspace "${ACTIVE_WS}"
