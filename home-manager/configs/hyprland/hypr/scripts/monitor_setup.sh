#!/usr/bin/env bash

# Check if laptop screen is available
if hyprctl monitors | grep -q "eDP-1"
then
    # Yes: send workspace 10 to it
    hyprctl dispatch moveworkspacetomonitor 10 DP-1
else
    # No: send back workspace 10 to external screen
    hyprctl dispatch moveworkspacetomonitor 10 DP-2
fi
