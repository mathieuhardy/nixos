# ==============================================================================
#
# Script name: nixos.fish
# Description: Fish configuration for NixOS
# Dependencies:
# GitHub: https://www.github.com/mathieuhardy/nixos
# License: https://www.github.com/mathieuhardy/nixos/LICENSE
# Contributors: Mathieu Hardy
#
# ==============================================================================

# ------------------------------------------------------------------------------
# Local functions
# ------------------------------------------------------------------------------

function __nixos_configure
    # Abbreviations
    abbr n 'nixos_help'

    abbr nr  'sudo nixos-rebuild switch'
    abbr ns  'find /nix/store -maxdepth 1 -name'
    abbr ngc 'sudo nix-collect-garbage -d'

    abbr nc  'nix-channel --list'
    abbr NC  'sudo nix-channel --list'
    abbr nca 'nix-channel --add'
    abbr ncr 'nix-channel --remove'
    abbr ncu 'nix-channel --update'

    abbr ng  'nix-env --list-generations'
    abbr NG  'nix-env --list-generations --profile /nix/var/nix/profiles/system'
    abbr ngd 'nix-env --delete-generations'
    abbr ngs 'nix-env --switch-generation'
    abbr ngr 'nix-env --rollback'

    abbr ns 'nix-env -qaP'
    abbr np 'nix-env -q'
    abbr ni 'nix-env -i'
    abbr nI 'nix-env -iA'
    abbr nu 'nix-env -e'

    abbr nsh 'nix-shell'
end

function __nixos_register
    set --local name 'nixos'

    if ! set --query __fish_modules
        set --universal __fish_modules ''
    end

    if ! string match -q -- $name $__fish_modules
        set --append __fish_modules $name
    end
end

# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

function nixos_init
    if not set --query __nixos_initialized
        set --universal __nixos_initialized

       __nixos_configure
    end
end

function nixos_reload
    set --erase __nixos_initialized
    nixos_init

    echo 'nixos_reload... done'
end

function nixos_help
    echo 'System:'
    echo '  nr                   Build and switch new configuration'
    echo '  ns <name>            Find a package in the store'
    echo '  ngc                  Garbage collect unused packages'
    echo ''
    echo 'Channels:'
    echo '  nc                   List channels'
    echo '  NC                   List system channels'
    echo '  nca <url> <name>     Add channel to list'
    echo '  ncr <name>           Remove channel from list'
    echo '  ncu                  Update list of channels'
    echo ''
    echo 'Generations:'
    echo '  ng                   List generations'
    echo '  NG                   List system generations'
    echo '  ngd <id ...>         Delete generations'
    echo '  ngs <id>             Switch to generation'
    echo '  ngr                  Rollback generation'
    echo ''
    echo 'Packages:'
    echo '  ns <name>            Search package'
    echo '  np                   List installed packages'
    echo '  ni                   Install package(s)'
    echo '  nI                   Install package(s) with full name'
    echo '  nu                   Uninstall package(s)'
    echo ''
    echo 'Shell:'
    echo '  nsh -p <package ...> Open a Nix shell'
end

# ------------------------------------------------------------------------------
# Entry point
# ------------------------------------------------------------------------------

__nixos_register
