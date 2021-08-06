#!/usr/bin/env sh

# ==============================================================================
#
# Script name: easier_cli.sh
# Description: Shell command line parser.
# Dependencies: easier_string.sh, easier_various.sh
# GitHub: https://www.github.com/mathieuhardy/nixos
# License: https://www.github.com/mathieuhardy/nixos/LICENSE
# Contributors: Mathieu Hardy
#
# This file provides a function to parse the command line options and arguments.
# To use it, simply call the function `cli_parse` and pass it the list of
# arguments: ${@}.
#
# Available configuration variables are:
#   * easier_cli_program: name of the program (used for displaying usage).
#
#   * easier_cli_version: version of the program (used for displaying usage).
#
#   * easier_cli_description: description of the program (used for displaying
#     usage).
#
#   * easer_cli_describe: array that must be filled with the list of supported
#     options.
#
#   * easer_cli_describe_separator: character used in describe to seperate
#     elements.
#
#   * easer_cli_args_required (default=0): tell that arguments are required on
#     the command line. This is used if checking
#                                        is enabled.
#
#   * easier_cli_enable_callbacks (default=0): whether some callbacks should be
#     called during the parsing.
#
#   * easier_cli_enable_eval_mode (default=1): whether the evaluation of the
#     result should be done. This will create variables accessible after the
#     parsing, such as `args`.
#
#   * easier_cli_enable_requirements_checking (default=1): whether the checking
#     of the command line should be done.
#
#   * easier_cli_usage_on_error (default=1): call the usage method when an error
#     is detected.
#
#   * easier_cli_exit_on_error (default=1): call exit when an error is detected.
#
# Functions that can be overriden by the user:
#   * cli_usage(): display the usage of the program.
#
#   * cli_version(): display the version of the program.
#
# Callbacks that can defined by the user and maybe called during the parsing:
#   * cli_error_no_args(): no arguments provided.
#
#   * cli_error_undefined(): option received is not defined in
#     `easer_cli_describe`.
#
#   * cli_error_missing(): a required option has not been provided.
#
#   * cli_error_duplicate(): a unique option has been provided twice or more.
#
# ==============================================================================

# ------------------------------------------------------------------------------
# Dependencies
# ------------------------------------------------------------------------------

# shellcheck source=/dev/null
. easier_string.sh
. easier_various.sh

# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

easier_cli_program='<undefined>'
easier_cli_version='<unknown_version>'
easier_cli_description=''

easer_cli_describe=()
easer_cli_describe_separator='|'

easer_cli_args_required=0

easier_cli_enable_callbacks=0
easier_cli_enable_eval_mode=1
easier_cli_enable_requirements_checking=1

easier_cli_usage_on_error=1
easier_cli_exit_on_error=1

# ------------------------------------------------------------------------------
# Private functions
# ------------------------------------------------------------------------------

# Description: Call a callback if possible
# Usage: __easier_cli_call_cbk 'cbk_name' 'arg' 'another_arg'
__easier_cli_call_cbk()
{
    if is_false "${easier_cli_enable_callbacks}"
    then
        return 0
    fi

    cbk=${1}
    shift

    if is_function "${cbk}"
    then
        eval "${cbk} \"${1}\""
    fi
}

# Description: Do actions on error
# Usage: __easier_cli_handle_error
__easier_cli_handle_error()
{
    if is_true "${easier_cli_usage_on_error}"
    then
        __easier_cli_call_cbk 'cli_usage'
    fi

    if is_true "${easier_cli_exit_on_error}"
    then
        exit 1
    fi
}

# Description: Check if an option name is valid
# Usage: is_name_valid "${opt}"
is_name_valid()
{
    if is_empty "${1}"
    then
        return 1
    fi

    [ "${1}" = '-' ] && return 1

    return 0
}

# ------------------------------------------------------------------------------
# Public functions
# ------------------------------------------------------------------------------

cli_usage()
{
    local s=
    local sep="${easer_cli_describe_separator}"

    for opt in "${easer_cli_describe[@]}"
    do
        required=$(trim $(token "${opt}" "${sep}" 1))
        occurence=$(trim $(token "${opt}" "${sep}" 2))
        takes_arg=$(trim $(token "${opt}" "${sep}" 3))
        short=$(trim $(token "${opt}" "${sep}" 4))
        long=$(trim $(token "${opt}" "${sep}" 5))
        description=$(token "${opt}" "${sep}" 6)
        description=$(trim "${description}")

        if is_name_valid "${short}"
        then
            s="${s}  -${short}"
        fi

        if is_name_valid "${short}" && is_name_valid "${long}"
        then
            s="${s},"
        else
            s="${s}  "
        fi

        if is_name_valid "${long}"
        then
            s="${s}--${long}"
        fi

        s="${s}\n    ${description}\n"

        [ "${required}" = 'r' ] \
            && s="${s}    [Required]" \
            || s="${s}    [Optional]"

        [ "${occurence}" = '1' ] \
            && s="${s} [Unique]" \
            || s="${s}         "

        [ "${takes_arg}" = '+' ] \
            && s="${s} [HasArgument]" \
            || s="${s}              "

        s="${s}\n\n"
    done

    if is_not_empty "${easier_cli_description}"
    then
        description="\n\n${easier_cli_description}"
    fi

    echo -e "$(cli_version)${description}\n\n${s}"
}

cli_version()
{
    echo "${easier_cli_program} (v${easier_cli_version})"
}

cli_parse()
{
    local output=
    local has_error=0
    local sed_rules=
    local sed_sep=�
    local describe_sep="${easer_cli_describe_separator}"

    # Build sed rules
    for opt in "${easer_cli_describe[@]}"
    do
        required=$(trim $(token "${opt}" "${describe_sep}" 1))
        occurence=$(trim $(token "${opt}" "${describe_sep}" 2))
        takes_arg=$(trim $(token "${opt}" "${describe_sep}" 3))
        short=$(trim $(token "${opt}" "${describe_sep}" 4))
        long=$(trim $(token "${opt}" "${describe_sep}" 5))

        if [ "${takes_arg}" = '+' ]
        then
            arg_suffix=" ([^-][^${sed_sep}]+) ${sed_sep}"
            replacement='"\1"'
        else
            replacement='1'
        fi

        if [ "${occurence}" = '1' ]
        then
            assignment_prefix=
        else
            assignment_prefix='+'
            replacement="(${replacement})"
        fi

        if is_name_valid "${short}"
        then
            # Add rule for short name
            sed_rules="${sed_rules}s|-${short} ${sed_sep}${arg_suffix}"
            sed_rules="${sed_rules}|--opt_${short}${assignment_prefix}="
            sed_rules="${sed_rules}${replacement} ${sed_sep}|g;"

            if is_name_valid "${long}"
            then
                # Add rules for long name but use the short name
                sed_rules="${sed_rules}s|--${long} ${sed_sep}${arg_suffix}"
                sed_rules="${sed_rules}|--opt_${short}${assignment_prefix}="
                sed_rules="${sed_rules}${replacement} ${sed_sep}|g;"

                sed_rules="${sed_rules}s|--${long}=([^${sed_sep}]+) ${sed_sep}"
                sed_rules="${sed_rules}|--opt_${short}${assignment_prefix}="
                sed_rules="${sed_rules}${replacement} ${sed_sep}|g;"
            fi
        elif is_name_valid "${long}"
        then
            # Add rules for long name
            sed_rules="${sed_rules}s|--${long} ${sed_sep}${arg_suffix}"
            sed_rules="${sed_rules}|--opt_${long}${assignment_prefix}="
            sed_rules="${sed_rules}${replacement} ${sed_sep}|g;"

            sed_rules="${sed_rules}s|--${long}=([^${sed_sep}]+) ${sed_sep}"
            sed_rules="${sed_rules}|--opt_${long}${assignment_prefix}="
            sed_rules="${sed_rules}${replacement} ${sed_sep}|g;"
        fi
    done

    # Format arguments
    sed_rules="${sed_rules}s|${sed_sep} ([^-${sed_sep}][^${sed_sep}]*) "
    sed_rules="${sed_rules}|${sed_sep} args+=(\"\1\") |g;"

    # Remove '--'
    sed_rules="${sed_rules}s|${sed_sep} --|${sed_sep} |g;"

    # Perform first step of replacements
    output=$(echo "${sed_sep} ${@/%/ ${sed_sep}}" | sed -E "${sed_rules}")

    # Check if we need to performs checks
    if is_true "${easier_cli_enable_requirements_checking}"
    then
        # Check if arguments are needed
        if is_true "${easer_cli_args_required}"
        then
            result=$(echo "${output}" | grep "${sed_sep} args+=")
            if is_empty "${result}"
            then
                __easier_cli_call_cbk 'cli_error_no_args'
                __easier_cli_handle_error

                has_error=1
            fi
        fi

        # Check if undefined option is provided
        result=$(echo "${output}" | grep "${sed_sep} -")
        if is_not_empty "${result}"
        then
            opt=$(echo "${output}" \
                | sed "s|^.*${sed_sep} -||g;s| ${sed_sep}.*$||g")

            __easier_cli_call_cbk 'cli_error_undefined' "${opt}"
            __easier_cli_handle_error

            has_error=1
        fi

        # Perform checks according to describe list
        for opt in "${easer_cli_describe[@]}"
        do
            required=$(trim $(token "${opt}" "${describe_sep}" 1))
            occurences=$(trim $(token "${opt}" "${describe_sep}" 2))
            short=$(trim $(token "${opt}" "${describe_sep}" 4))
            long=$(trim $(token "${opt}" "${describe_sep}" 5))

            if is_name_valid "${short}"
            then
                name="${short}"
            else
                name="${long}"
            fi

            # Check if a required option is missing
            if [ "${required}" = 'r' ]
            then
                result=$(echo "${output}" | grep "${sed_sep} opt_${name}[+=]")
                if is_empty "${result}"
                then
                    __easier_cli_call_cbk 'cli_error_missing' "${name}"
                    __easier_cli_handle_error

                    has_error=1
                fi
            fi

            # Check occurences
            if [ "${occurences}" = '1' ]
            then
                result=$(echo "${output}" \
                    | grep "${sed_sep} opt_${name}=.*${sed_sep} opt_${name}=")

                if is_not_empty "${result}"
                then
                    __easier_cli_call_cbk 'cli_error_duplicate' "${name}"
                    __easier_cli_handle_error

                    has_error=1
                fi
            fi

            # No need to check options that take argument as they appear as
            # undefined options
        done
    fi

    # Remove undefined options so that we can eval the output
    sed_rules="s|${sed_sep} -{1,2}[^${sed_sep}]+ ${sed_sep}| ${sed_sep}|g"

    output=$(echo "${output}" | sed -E "${sed_rules}")

    # Remove unicode separators
    output=$(echo "${output}" | sed -E "s| ${sed_sep}||g;s|${sed_sep} ||g")

    # Evaluate the result
    if is_true "${easier_cli_enable_eval_mode}"
    then
        eval "${output}"
    fi

    return ${has_error}
}
