#!/usr/bin/env sh

# ==============================================================================
#
# Script name: easier_string.sh
# Description: Shell framework for string manipulation
# Dependencies:
# GitHub: https://www.github.com/mathieuhardy/nixos
# License: https://www.github.com/mathieuhardy/nixos/LICENSE
# Contributors: Mathieu Hardy
#
# ==============================================================================

# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

# Description: Trim leading white-spaces
# Usage: ltrim "  bla bla"
ltrim()
{
    # Remove all leading white-space.
    # '${1%%[![:space:]]*}': Strip everything but leading white-space.
    # '${1#${XXX}}': Remove the white-space from the start of the string.
    trim=${1#${1%%[![:space:]]*}}

    printf '%s\n' "${trim}"
}

# Description: Trim trailing white-spaces
# Usage: ltrim "bla bla  "
rtrim()
{
    # Remove all trailing white-space.
    # '${trim##*[![:space:]]}': Strip everything but trailing white-space.
    # '${trim%${XXX}}': Remove the white-space from the end of the string.
    trim=${1%${1##*[![:space:]]}}

    printf '%s\n' "${trim}"
}

# Description: Trim leading and trailing white-spaces
# Usage: trim "  bla bla  "
trim()
{
    trim=$(ltrim "${1}")
    trim=$(rtrim "${trim}")

    printf '%s\n' "${trim}"
}

# Description: Trim leading and trailing white-spaces and remove duplicate
#              white-spaces inside the string.
# Usage: trim_and_uniq "  bla  bla  "
trim_and_uniq()
{
    # Disable globbing to make the word-splitting below safe.
    set -f

    # Set the argument list to the word-splitted string.
    # This removes all leading/trailing white-space and reduces
    # all instances of multiple spaces to a single ("  " -> " ").
    set -- ${*}

    printf '%s\n' "${*}"

    # Re-enable globbing.
    set +f
}

# Description: Trim quotes in a string
# Usage: trim_quotes "\"bla bla\""
trim_quotes()
{
    # Disable globbing.
    # This makes the word-splitting below safe.
    set -f

    # Store the current value of 'IFS' so we
    # can restore it later.
    old_ifs=${IFS}

    # Set 'IFS' to ["'].
    IFS=\"\'

    # Create an argument list, splitting the
    # string at ["'].
    #
    # Disable this shellcheck error as it only
    # warns about word-splitting which we expect.
    # shellcheck disable=2086
    set -- ${1}

    # Set 'IFS' to blank to remove spaces left
    # by the removal of ["'].
    IFS=

    # Print the quote-less string.
    printf '%s\n' "$*"

    # Restore the value of 'IFS'.
    IFS=${old_ifs}

    # Re-enable globbing.
    set +f
}

# Description: Prefix the string
# Usage: prefix "world" "Hello "
prefix()
{
    printf '%s\n' "${1/#/${2}}"
}

# Description: Suffix the string
# Usage: Suffix "Hello" " world"
suffix()
{
    printf '%s\n' "${1/%/${2}}"
}

# Description: Surround the string with a prefix and suffix
# Usage: surround 'str' 'prefix' 'suffix'
# Usage: surround 'str' 'prefix_and_suffix'
surround()
{
    if [ "${#}" -eq 2 ]
    then
        suffix="${2}"
    else
        suffix="${3}"
    fi

    s=$(prefix "${1}" "${2}")
    s=$(suffix "${s}" "${suffix}")

    printf '%s\n' "${s}"
}

# Description: Check if a string contains another string
# Usage: contains "  bla bla  " "bla"
contains()
{
    [ -n "${2}" ] || return 1

    case "${1}" in
        *${2}*)
            return 0
            ;;

        *)
            return 1
            ;;
    esac
}

# Description: Check if a string starts with another string
# Usage: starts_with "  bla bla  " "  bla"
starts_with()
{
    case ${1} in
        ${2}*)
            return 0
        ;;

        *)
            return 1
        ;;
    esac
}

# Description: Check if a string ends with another string
# Usage: ends_with "  bla bla  " "bla  "
ends_with()
{
    case ${1} in
        *${2})
            return 0
        ;;

        *)
            return 1
        ;;
    esac
}

# Description: Split a string on a delimiter
# Usage: split "bla, bla, bla" ", "
split()
{
    # Disable globbing.
    # This ensures that the word-splitting is safe.
    set -f

    # Store the current value of 'IFS' so we
    # can restore it later.
    old_ifs=${IFS}

    # Change the field separator to what we're
    # splitting on.
    IFS=${2}

    # Create an argument list splitting at each
    # occurance of '$2'.
    #
    # This is safe to disable as it just warns against
    # word-splitting which is the behavior we expect.
    # shellcheck disable=2086
    set -- ${1}

    # Print each list value on its own line.
    printf '%s\n' "$@"

    # Restore the value of 'IFS'.
    IFS=${old_ifs}

    # Re-enable globbing.
    set +f
}

# Description: Remove shortest pattern at start of string
# Usage: lstrip "Hello World" "Hello "
lstrip()
{
    printf '%s\n' "${1#${2}}"
}

# Description: Remove shortest pattern at start of string
# Usage: lstrip_long "Hello World" "*l"
lstrip_long()
{
    printf '%s\n' "${1##${2}}"
}

# Description: Remove shortest pattern at end of string
# Usage: rstrip "Hello World" " World"
rstrip()
{
    printf '%s\n' "${1%${2}}"
}

# Description: Remove longest pattern at end of string
# Usage: rstrip_long "Hello World" "o*"
rstrip_long()
{
    printf '%s\n' "${1%%${2}}"
}

# Description: Get length of string in characters
# Usage: len "Hello World"
len()
{
    printf '%s\n' "${#1}"
}

# Description: Get a substring
# Usage: substr "Hello World" 1 5
substr()
{
    printf '%s\n' "${1:${2}:${3}}"
}

# Description: Replace first match of pattern
# Usage: replace "Hello World" "World" "Man"
replace()
{
    printf '%s\n' "${1/${2}/${3}}"
}

# Description: Replace all matches of pattern
# Usage: replace "Hello World" "World" "Man"
replace_all()
{
    printf '%s\n' "${1//${2}/${3}}"
}

# Description: Check if a string is empty
# Usage: is_empty "Hello World"
is_empty()
{
    [ -z "${1}" ] && return 0 || return 1
}

# Description: Check if a string is not empty
# Usage:  "Hello World"
is_not_empty()
{
    [ -n "${1}" ] && return 0 || return 1
}
