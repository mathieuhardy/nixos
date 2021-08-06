#!/usr/bin/env sh

# ==============================================================================
#
# Script name: easier_various.sh
# Description: Shell framework with various functions
# Dependencies:
# GitHub: https://www.github.com/mathieuhardy/nixos
# License: https://www.github.com/mathieuhardy/nixos/LICENSE
# Contributors: Mathieu Hardy
#
# ==============================================================================

# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

# Description: Get number of elements
# Usage: count 1 2 3
count()
{
    printf '%s\n' "$#"
}

# Description: Ask for a user confirmation
# Usage: confirm "default_value" "Hello world"
confirm()
{
    local default_value=${1}
    shift

    case ${default_value} in
        "y" | "Y")
            prompt="Y/n"
            ;;

        "n" | "N")
            prompt="y/N"
            ;;

        *)
            exit 1
            ;;
    esac

    printf "\n\033[1m%s ? ${prompt} \033[0m" "${@}"

    read -n 1

    if [ -z "${REPLY}" ]
    then
        REPLY=${default_value}
    fi

    printf "\n"
}

# Description: Check if user as confirmed the previous request
# Usage: is_confirmed
is_confirmed()
{
    [[ "$REPLY" =~ ^[Yy]$ ]] && return 0 || return 1
}

# Description: Check if tool is available in path
# Usage: has firefox
has()
{
    command -v "${1}" >/dev/null && return 0 || return 1
}

# Description: Check if tool is available in path and exit if not found
# Usage: requires firefox
requires()
{
    if ! has "${1}"
    then
        echo "Missing '${1}'" 1>&2
        exit 1
    fi
}

# Description: Check if value is true
# Usage: is_true 1
is_true()
{
    [ "${1}" -eq 1 ] && return 0 || return 1
}

# Description: Check if value is false
# Usage: is_false 0
is_false()
{
    [ "${1}" -eq 0 ] && return 0 || return 1
}

# Description: Check if argument is a function
# Usage: is_function 'cbk'
is_function()
{
    [[ $(type -t "${1}") == function ]] && return 0 || return 1
}

# Description: Get specific token from a split
# Usage: token "input" 'separator' ${idx}
token()
{
    echo "${1}" | cut -d "${2}" -f "${3}"
}
