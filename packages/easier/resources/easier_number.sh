#!/usr/bin/env sh

# ==============================================================================
#
# Script name: easier_number.sh
# Description: Shell framework for number manipulation
# Dependencies:
# GitHub: https://www.github.com/mathieuhardy/nixos
# License: https://www.github.com/mathieuhardy/nixos/LICENSE
# Contributors: Mathieu Hardy
#
# ==============================================================================

# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

# Description: Check if a value is a float
# Usage: is_float "0.1"
is_float()
{
    # The test checks to see that the input contains a '.'. This filters out
    # whole numbers.
    [ -z "${1##*.*}" ] && return 0 || return 1
}

# Description: Check if a value is an integer
# Usage: is_int "1"
is_int()
{
    printf "%d" "${1}" >/dev/null 2>&1
}
