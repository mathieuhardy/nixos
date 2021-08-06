#!/usr/bin/env sh

# ==============================================================================
#
# Script name: easier_fs.sh
# Description: Shell framework for filesystem manipulation
# Dependencies:
# GitHub: https://www.github.com/mathieuhardy/nixos
# License: https://www.github.com/mathieuhardy/nixos/LICENSE
# Contributors: Mathieu Hardy
#
# ==============================================================================

# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

# Description: Check if a path is a directory
# Usage: is_directory path
is_directory()
{
    [ -d "${1}" ] && return 0 || return 1
}

# Description: Check if a path is a regular file
# Usage: is_file path
is_file()
{
    [ -f "${1}" ] && return 0 || return 1
}

# Description: Check if a path is a block device
# Usage: is_block_device path
is_block_device()
{
    [ -b "${1}" ] && return 0 || return 1
}

# Description: Check if a path is a character special file
# Usage: is_character_special path
is_character_special()
{
    [ -c "${1}" ] && return 0 || return 1
}

# Description: Check if a path is a symbolic link
# Usage: is_link path
is_link()
{
    [ -h "${1}" ] && return 0 || return 1
}

# Description: Check if a path is a named pipe
# Usage: is_pipe path
is_pipe()
{
    [ -p "${1}" ] && return 0 || return 1
}

# Description: Check if a path is a socket
# Usage: is_socket path
is_socket()
{
    [ -S "${1}" ] && return 0 || return 1
}

# Description: Check if a path is readable
# Usage: is_readable path
is_readable()
{
    [ -r "${1}" ] && return 0 || return 1
}

# Description: Check if a path is writable
# Usage: is_writable path
is_writable()
{
    [ -w "${1}" ] && return 0 || return 1
}

# Description: Check if a path is executable
# Usage: is_executable path
is_executable()
{
    [ -x "${1}" ] && return 0 || return 1
}

# Description: Check if group-id is set
# Usage: setgid_is_set path
setgid_is_set()
{
    [ -g "${1}" ] && return 0 || return 1
}

# Description: Check if set-user-id is set
# Usage: setuid_is_set path
setuid_is_set()
{
    [ -u "${1}" ] && return 0 || return 1
}

# Description: Check if a file is not empty
# Usage: file_is_not_empty path
file_is_not_empty()
{
    [ -s "${1}" ] && return 0 || return 1
}

# Description: Check if a path exists
# Usage: exists path
exists()
{
    [ -e "${1}" ] && return 0 || return 1
}
