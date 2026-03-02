#!/usr/bin/env bash

set -e

RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
NC="\033[0m"

function log() {
    msg="${1}"
    now=$(date)

    echo "${now}: ${msg}" >> ${LOGS}
}

function trace() {
    color="${1}"
    msg="${2}"

    log "${msg}"
    echo -e "${color}${msg}${NC}"
}

# Logs
LOGS=/tmp/monitor-setup.log
echo "" >> ${LOGS}

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

log "HAS_INTERNAL=${HAS_INTERNAL}"
log "HAS_EXTERNAL=${HAS_EXTERNAL}"

# Handle profiles
if [[ "${HAS_INTERNAL}" = "true" ]] && [[ "${HAS_EXTERNAL}" = "false" ]]
then
    # Assign all workspaces to internal
    trace "${BLUE}" "🖵 Assign workspace 1 to ${INTERNAL} (as default)"
    hyprctl -q keyword workspace "1,monitor:${INTERNAL},persistent:true,default:true"

    for ws in {2..10}
    do
        trace "${BLUE}" "🖵 Assign workspace ${ws} to ${INTERNAL}"
        hyprctl -q keyword workspace "${ws},monitor:${INTERNAL},persistent:true"
    done

    # Enable monitor
    trace "${GREEN}" "⏻ Enabling internal: ${INTERNAL}"
    hyprctl -q keyword monitor "${INTERNAL},preferred,auto,1"

    # Move workspace if needed
    trace "${BLUE}" "⮊ Move workspace 1 to ${INTERNAL}"
    hyprctl -q dispatch moveworkspacetomonitor 1 "${INTERNAL}"

    for ws in {2..10}
    do
        trace "${BLUE}" "⮊ Move workspace ${ws} to ${INTERNAL}"
        hyprctl -q dispatch moveworkspacetomonitor "${ws}" "${INTERNAL}"
    done
elif [[ "${HAS_INTERNAL}" = "false" ]] && [[ "${HAS_EXTERNAL}" = "true" ]]
then
    # Disable monitor
    trace "${RED}" "✖ Disabling internal: ${INTERNAL}"
    hyprctl -q keyword monitor "${INTERNAL},disable"

    # Assign all workspaces to external
    trace "${BLUE}" "🖵 Assign workspace 1 to ${EXTERNAL} (as default)"
    hyprctl -q keyword workspace "1,monitor:${EXTERNAL},persistent:true,default:true"

    trace "${BLUE}" "⮊ Move workspace 1 to ${EXTERNAL}"
    hyprctl -q dispatch moveworkspacetomonitor 1 "${EXTERNAL}"

    for ws in {2..10}
    do
        trace "${BLUE}" "🖵 Assign workspace ${ws} to ${EXTERNAL}"
        hyprctl -q keyword workspace "${ws},monitor:${EXTERNAL},persistent:true"

        trace "${BLUE}" "⮊ Move workspace ${ws} to ${EXTERNAL}"
        hyprctl -q dispatch moveworkspacetomonitor "${ws}" "${EXTERNAL}"
    done
elif [[ "${HAS_INTERNAL}" = "true" ]] && [[ "${HAS_EXTERNAL}" = "true" ]]
then
    # All except 10 to external
    trace "${BLUE}" "🖵 Assign workspace 1 to ${EXTERNAL} (as default)"
    hyprctl -q keyword workspace "1,monitor:${EXTERNAL},persistent:true,default:true"

    trace "${BLUE}" "⮊ Move workspace 1 to ${EXTERNAL}"
    hyprctl -q dispatch moveworkspacetomonitor 1 "${EXTERNAL}"

    for ws in {2..9}
    do
        trace "${BLUE}" "🖵 Assign workspace ${ws} to ${EXTERNAL}"
        hyprctl -q keyword workspace "${ws},monitor:${EXTERNAL},persistent:true"

        trace "${BLUE}" "⮊ Move workspace ${ws} to ${EXTERNAL}"
        hyprctl -q dispatch moveworkspacetomonitor "${ws}" "${EXTERNAL}"
    done

    # Workspace 10 to internal
    trace "${BLUE}" "🖵 Assign workspace 10 to ${INTERNAL} (as default)"
    hyprctl keyword workspace "10,monitor:${INTERNAL},persistent:true,default:true"

    # Enable monitor
    trace "${GREEN}" "⏻ Enabling internal: ${INTERNAL}"
    hyprctl keyword monitor "${INTERNAL},preferred,auto,1"

    # Move workspace
    trace "${BLUE}" "⮊ Move workspace 10 to ${INTERNAL}"
    hyprctl dispatch moveworkspacetomonitor 10 "${INTERNAL}"
fi

# Jump back to active
trace "${BLUE}" "⮊ Jump back to workspace ${ACTIVE_WS}"
hyprctl -q dispatch workspace "${ACTIVE_WS}"
