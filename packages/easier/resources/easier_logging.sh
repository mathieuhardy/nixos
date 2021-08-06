#!/usr/bin/env sh

# ==============================================================================
#
# Script name: easier_logging.sh
# Description: Shell framework for logging
# Dependencies:
# GitHub: https://www.github.com/mathieuhardy/nixos
# License: https://www.github.com/mathieuhardy/nixos/LICENSE
# Contributors: Mathieu Hardy
#
# ==============================================================================

# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

easier_logging_no_icons=0
easier_logging_icon_success="✔"
easier_logging_icon_error="✖"
easier_logging_icon_warning="!"
easier_logging_icon_info="➜"
easier_logging_icon_debug=">"
easier_logging_icon_trace="."

easier_logging_no_icon_color=0
easier_logging_no_text_color=1

# ------------------------------------------------------------------------------
# Private functions
# ------------------------------------------------------------------------------

__easier_logging_print()
{
    local color=${1}
    shift

    local icon=${1}
    shift

    [ ${easier_logging_no_text_color} -eq 0 ] \
       && text_color="${color}" \
       || text_color=""

    [ ${easier_logging_no_icon_color} -eq 0 ] \
       && icon_color="${color}" \
       || icon_color=""

    [ ${easier_logging_no_icons} -eq 0 ] \
       && icon="${icon_color}${icon}\033[0m " \
       || icon=""

    printf "${icon}${text_color}%s\033[0m\n" "${@}"
}

# ------------------------------------------------------------------------------
# Public functions
# ------------------------------------------------------------------------------

# Description: Print a success message
# Usage: success "Hello World"
success()
{
    __easier_logging_print "\033[32m" "${easier_logging_icon_success}" "${@}"
}

# Description: Print an error message
# Usage: error "Hello World"
error()
{
    __easier_logging_print "\033[31m" "${easier_logging_icon_error}" "${@}"
}

# Description: Print a warning message
# Usage: warning "Hello World"
warning()
{
    __easier_logging_print "\033[33m" "${easier_logging_icon_warning}" "${@}"
}

# Description: Print an info message
# Usage: info "Hello World"
info()
{
    __easier_logging_print "\033[34m" "${easier_logging_icon_info}" "${@}"
}

# Description: Print a debug message
# Usage: debug "Hello World"
debug()
{
    __easier_logging_print "\033[35m" "${easier_logging_icon_debug}" "${@}"
}

# Description: Print a trace message
# Usage: trace "Hello World"
trace()
{
    __easier_logging_print "\033[0m" "${easier_logging_icon_trace}" "${@}"
}

# Description: Print a bold message
# Usage: bold "Hello World"
bold()
{
    printf "\033[1m%s\033[0m\n" "${@}"
}

# Description: Print a dim message
# Usage: dim "Hello World"
dim()
{
    printf "\033[2m%s\033[0m\n" "${@}"
}

# Description: Print an underlined message
# Usage: underlined "Hello World"
underlined()
{
    printf "\033[4m%s\033[0m\n" "${@}"
}

# Description: Print an blinking message
# Usage: blink "Hello World"
blink()
{
    printf "\033[5m%s\033[0m\n" "${@}"
}

# Description: Print an inverted message
# Usage: inverted "Hello World"
inverted()
{
    printf "\033[7m%s\033[0m\n" "${@}"
}

# Description: Print a hidden message
# Usage: hidden "Hello World"
hidden()
{
    printf "\033[8m%s\033[0m\n" "${@}"
}
