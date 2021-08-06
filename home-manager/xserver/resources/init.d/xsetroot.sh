#!/usr/bin/env sh

# ==============================================================================
#
# Script name: xsetroot.sh
# Description: Configure X server options (meant to be called at the init of a
#              window manager).
# Dependencies: xsetroot
# GitHub: https://www.github.com/mathieuhardy/nixos
# License: https://www.github.com/mathieuhardy/nixos/LICENSE
# Contributors: Mathieu Hardy
#
# ==============================================================================

# ------------------------------------------------------------------------------
# Dependencies
# ------------------------------------------------------------------------------

if ! command -v xsetroot >/dev/null
then
    echo "Missing 'xsetroot'" 1>&2
    exit 1
fi

# ------------------------------------------------------------------------------
# Entry point
# ------------------------------------------------------------------------------

# Remove ugly cross
xsetroot -cursor_name left_ptr
