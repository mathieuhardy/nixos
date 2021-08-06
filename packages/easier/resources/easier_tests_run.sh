#!/usr/bin/env sh

# ==============================================================================
#
# Script name: easier_tests_run.sh
# Description: Unit testing of easier.
# Dependencies: easier.sh, mkfifo, ss
# GitHub: https://www.github.com/mathieuhardy/nixos
# License: https://www.github.com/mathieuhardy/nixos/LICENSE
# Contributors: Mathieu Hardy
#
# ==============================================================================

# ------------------------------------------------------------------------------
# Dependencies
# ------------------------------------------------------------------------------

PATH="${PATH}:."
. easier.sh

# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

script_dir=$(dirname "${0}")
file=${0}
link=/tmp/easier_testing_link
non_readable=/tmp/easier_testing_non_readable
non_writable=/tmp/easier_testing_non_writable
writable=/tmp/easier_testing_writable
non_empty=/tmp/easier_testing_non_empty
non_executable=/tmp/easier_testing_non_executable
pipe=/tmp/easier_testing_pipe
setuid=/tmp/easier_testing_setuid
setgid=/tmp/easier_testing_setgid
socket=$(ss | egrep /tmp | head -n 1 | sed -E 's|.*(/tmp[^ ]*) .*$|\1|g')

f()
{
    echo '' >/dev/null
}

# ------------------------------------------------------------------------------
# Tests
# ------------------------------------------------------------------------------

# Initialization
ln -sf ${file} ${link}

:>${non_readable}
chmod -r ${non_readable}

[ -e "${non_writable}" ] || :>${non_writable}
chmod -w ${non_writable}

:>${writable}

echo 'Hello world' > ${non_empty}

:>${non_executable}
chmod -x ${non_executable}

rm -f ${pipe}
mkfifo ${pipe}

:>${setuid}
chmod 4755 ${setuid}

:>${setgid}
chmod 2755 ${setgid}

# cli
easier_cli_program='easier_tests_run'
easier_cli_version='0.0.0'
easer_cli_describe_separator='#'
easier_cli_usage_on_error=0
easier_cli_exit_on_error=0
easer_cli_args_required=1
easier_cli_enable_callbacks=1

easer_cli_describe=( \
    'o # 1 # - # h # -       # Show this help and exit' \
    'o # 1 # - # - # version # Display version' \
    'o # 1 # + # t # -       # Bla bla' \
    'o # 1 # + # - # uuu     # Bla bla 2' \
    'o # * # + # s # short   # Bla bla 3' \
    'r # * # + # f # file    # Bla bla 4' \
    'r # * # + # l # long    # Bla bla 5' )

cli_error_missing()
{
    expect_eq "${1}" 'f'
}

idx=0

cli_error_duplicate()
{
    case ${idx} in
        0)
            expect_eq "${1}" 'h'
            idx=$(( ++idx ))
            ;;

        1)
            expect_eq "${1}" 'version'
            idx=$(( ++idx ))
            ;;

        2)
            expect_eq "${1}" 'uuu'
            ;;
    esac
}

cli_parse "${cli_desc[@]}" \
    'arg_1' \
    'z' \
    -h \
    -h \
    -h \
    --version \
    --version \
    --version \
    -s 's_1' \
    'arg_2' \
    -s 's_2' \
    -s 's_3' \
    -s \
    --short 's_4' \
    --long 'l_1' \
    --long 'l_2' \
    --long 'l_3' \
    --long='Hello  world' \
    --long='Hello -- world' \
    --uuu='uuu_1' \
    'arg_3' \
    'arg_4' \
    'arg_5' \
    --uuu='uuu_2'

expect_eq "${opt_h}" 1
expect_eq "${opt_version}" 1

expect_eq "${#opt_s[@]}" 4
expect_eq "${opt_s[0]}" 's_1'
expect_eq "${opt_s[1]}" 's_2'
expect_eq "${opt_s[2]}" 's_3'
expect_eq "${opt_s[3]}" 's_4'

expect_eq "${#opt_l[@]}" 5
expect_eq "${opt_l[0]}" 'l_1'
expect_eq "${opt_l[1]}" 'l_2'
expect_eq "${opt_l[2]}" 'l_3'
expect_eq "${opt_l[3]}" 'Hello  world'
expect_eq "${opt_l[4]}" 'Hello -- world'

expect_eq "${opt_uuu}" 'uuu_2'

expect_eq "${#args[@]}" 6
expect_eq "${args[0]}" 'arg_1'
expect_eq "${args[1]}" 'z'
expect_eq "${args[2]}" 'arg_2'
expect_eq "${args[3]}" 'arg_3'
expect_eq "${args[4]}" 'arg_4'
expect_eq "${args[5]}" 'arg_5'

# fs
easier_testing_step 'is_directory@success'
expect_success $(is_directory ${script_dir})

easier_testing_step 'is_directory@error'
expect_fail $(is_directory ${file})

easier_testing_step 'is_file@success'
expect_success $(is_file ${file})

easier_testing_step 'is_file@error'
expect_fail $(is_file ${script_dir})

easier_testing_step 'is_block_device@success'
expect_success $(is_block_device '/dev/loop0')

easier_testing_step 'is_block_device@error'
expect_fail $(is_block_device "${file}")

easier_testing_step 'is_character_special@success'
expect_success $(is_character_special '/dev/tty')

easier_testing_step 'is_character_special@error'
expect_fail $(is_character_special "${file}")

easier_testing_step 'is_link@success'
expect_success $(is_link ${link})

easier_testing_step 'is_link@error'
expect_fail $(is_link ${file})

easier_testing_step 'is_pipe@success'
expect_success $(is_pipe ${pipe})

easier_testing_step 'is_pipe@error'
expect_fail $(is_pipe ${file})

easier_testing_step 'is_socket@success'
expect_success $(is_socket "${socket}")

easier_testing_step 'is_socket@error'
expect_fail $(is_socket "${file}")

easier_testing_step 'is_readable@success'
expect_success $(is_readable ${file})

easier_testing_step 'is_readable@error'
expect_fail $(is_readable ${non_readable})

easier_testing_step 'is_writable@success'
expect_success $(is_writable ${writable})

easier_testing_step 'is_writable@error'
expect_fail $(is_writable ${non_writable})

easier_testing_step 'is_executable@success'
expect_success $(is_executable ${file})

easier_testing_step 'is_executable@error'
expect_fail $(is_executable ${non_executable})

easier_testing_step 'setuid_is_set@success'
expect_success $(setuid_is_set ${setuid})

easier_testing_step 'setuid_is_set@error'
expect_fail $(setuid_is_set ${file})

easier_testing_step 'setgid_is_set@success'
expect_success $(setgid_is_set ${setgid})

easier_testing_step 'setgid_is_set@error'
expect_fail $(setgid_is_set ${file})

easier_testing_step 'file_is_not_empty@success'
expect_success $(file_is_not_empty "${non_empty}")

easier_testing_step 'file_is_not_empty@error'
expect_fail $(file_is_not_empty "${writable}")

easier_testing_step 'exists@success'
expect_success $(exists ${file})

easier_testing_step 'exists@error'
expect_fail $(exists /path-that-should-not-exist)

# number
easier_testing_step 'is_float@success'
expect_success $(is_float '1.0')

easier_testing_step 'is_float@error'
expect_fail $(is_float '1')

easier_testing_step 'is_int@success'
expect_success $(is_int '1')

easier_testing_step 'is_int@error'
expect_fail $(is_int 'Hello world')

# string
easier_testing_step 'ltrim'
expect_eq "$(ltrim '  Hello world')" 'Hello world'

easier_testing_step 'rtrim'
expect_eq "$(rtrim 'Hello world  ')" 'Hello world'

easier_testing_step 'trim'
expect_eq "$(trim '  Hello world  ')" 'Hello world'

easier_testing_step 'trim_and_uniq'
expect_eq "$(trim_and_uniq '  Hello  world  ')" 'Hello world'

easier_testing_step 'trim_quotes'
expect_eq "$(trim_quotes '"Hello world"')" 'Hello world'

easier_testing_step 'prefix'
expect_eq "$(prefix 'world' 'Hello ')" 'Hello world'

easier_testing_step 'suffix'
expect_eq "$(suffix 'Hello' ' world')" 'Hello world'

easier_testing_step 'surround@full'
expect_eq "$(surround 'Hello world' 'a_' '_z')" 'a_Hello world_z'

easier_testing_step 'surround@single'
expect_eq "$(surround 'Hello world' 'x')" 'xHello worldx'

easier_testing_step 'contains@success'
expect_success $(contains 'Hello world' 'Hello')

easier_testing_step 'contains@error'
expect_fail $(contains 'Hello world' 'bla')

easier_testing_step 'starts_with@success'
expect_success $(starts_with 'Hello world' 'Hello')

easier_testing_step 'ends_with@success'
expect_success $(ends_with 'Hello world' 'world')

idx=0

for token in $(split 'one;two;three;four' ';')
do
    case ${idx} in
        0)
            expect_eq "${token}" 'one'
            idx=$(( ++idx ))
            ;;

        1)
            expect_eq "${token}" 'two'
            idx=$(( ++idx ))
            ;;

        2)
            expect_eq "${token}" 'three'
            idx=$(( ++idx ))
            ;;

        3)
            expect_eq "${token}" 'four'
            ;;
    esac
done

easier_testing_step 'lstrip'
expect_eq "$(lstrip 'Hello world' 'H*o')" ' world'

easier_testing_step 'lstrip_long'
expect_eq "$(lstrip_long 'Hello world' 'H*o')" 'rld'

easier_testing_step 'rstrip'
expect_eq "$(rstrip 'Hello world' 'o*')" 'Hello w'

easier_testing_step 'rstrip_long'
expect_eq "$(rstrip_long 'Hello world' 'o*')" 'Hell'

easier_testing_step 'len'
expect_eq "$(len 'Hello world')" 11

easier_testing_step 'substr'
expect_eq "$(substr 'Hello world' 2 5)" 'llo w'

easier_testing_step 'replace'
expect_eq "$(replace 'Hello world' 'world' 'Man')" 'Hello Man'

easier_testing_step 'replace_all'
expect_eq \
    "$(replace_all 'Hello world world' 'world' 'Man')" \
    'Hello Man Man'

easier_testing_step 'is_empty@success'
expect_success $(is_empty '')

easier_testing_step 'is_empty@error'
expect_fail $(is_empty 'Hello world')

easier_testing_step 'is_not_empty@success'
expect_success $(is_not_empty 'Hello world')

easier_testing_step 'is_not_empty@error'
expect_fail $(is_not_empty '')

# various
expect_eq "$(count 'Hello' 'world')" 2

easier_testing_step 'has@success'
expect_success $(has '/usr/bin/env')

easier_testing_step 'has@error'
expect_fail $(has '/null')

easier_testing_step 'requires@success'
expect_success $(requires '/usr/bin/env')

easier_testing_step 'is_true@success'
expect_success $(is_true 1)

easier_testing_step 'is_true@error'
expect_fail $(is_true 0)

easier_testing_step 'is_false@success'
expect_success $(is_false 0)

easier_testing_step 'is_false@error'
expect_fail $(is_false 1)

easier_testing_step 'is_function@success'
expect_success $(is_function f)

easier_testing_step 'is_function@error'
expect_fail $(is_function b)

easier_testing_step 'token@success'
expect_eq "$(token 'one two three' ' ' 2)" 'two'
