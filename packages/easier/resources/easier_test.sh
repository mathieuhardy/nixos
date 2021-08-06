#!/usr/bin/env sh

# ==============================================================================
#
# Script name: easier_test.sh
# Description: Shell framework for testing
# Dependencies: easier_logging.sh
# GitHub: https://www.github.com/mathieuhardy/nixos
# License: https://www.github.com/mathieuhardy/nixos/LICENSE
# Contributors: Mathieu Hardy
#
# ==============================================================================

# ------------------------------------------------------------------------------
# Dependencies
# ------------------------------------------------------------------------------

# shellcheck source=/dev/null
. easier_logging.sh

# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

easier_testing_no_success_logs=0
easier_testing_no_error_logs=0

# ------------------------------------------------------------------------------
# Public functions
# ------------------------------------------------------------------------------

easier_testing_step()
{
    bold "$(info "${@}")"
}

# Description: Expect that two elements are equals
# Usage: expect_eq "1" "1"
expect_eq()
{
    if [ "${1}" = "${2}" ]
    then
        [ ${easier_testing_no_success_logs} -eq 0 ] \
            && success "\"${1}\" is equal to \"${2}\""
    else
        [ ${easier_testing_no_error_logs} -eq 0 ] \
            && error "\"${1}\" is not equal to \"${2}\""

        exit 1
    fi
}

# Description: Expect that two elements are not equals
# Usage: expect_ne "1" "2"
expect_ne()
{
    if [ "${1}" != "${2}" ]
    then
        [ ${easier_testing_no_success_logs} -eq 0 ] \
            && success "\"${1}\" is equal to \"${2}\""
    else
        [ ${easier_testing_no_error_logs} -eq 0 ] \
            && error "\"${1}\" is not equal to \"${2}\""

        exit 1
    fi
}

# Description: Expect that the last command succeed
# Usage: expect_success $(cmd) "message"
expect_success()
{
    if [ ${?} -eq 0 ]
    then
        if [ ${easier_testing_no_success_logs} -eq 0 ]
        then
            [ "${#@}" -ne 0 ] && success "${@}" || success "command succeed"
        fi
    else
        if [ ${easier_testing_no_error_logs} -eq 0 ]
        then
            [ "${#@}" -ne 0 ] && error "${@}" || error "command failed"
        fi

        exit 1
    fi
}

# Description: Expect that the last command failed
# Usage: expect_fail $(cmd) "message"
expect_fail()
{
    if [ ${?} -ne 0 ]
    then
        if [ ${easier_testing_no_success_logs} -eq 0 ]
        then
            [ "${#@}" -ne 0 ] && success "${@}" || success "command failed"
        fi
    else
        if [ ${easier_testing_no_error_logs} -eq 0 ]
        then
            [ "${#@}" -ne 0 ] && error "${@}" || error "command succeed"
        fi

        exit 1
    fi
}
