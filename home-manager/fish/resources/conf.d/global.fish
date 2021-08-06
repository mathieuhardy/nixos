################################################################################
#
# Script name: global.fish
# Description: Global fish configuration.
# Dependencies:
# GitHub: https://www.github.com/mathieuhardy/nixos
# License: https://www.github.com/mathieuhardy/nixos/LICENSE
# Contributors: Mathieu Hardy
#
################################################################################

# ------------------------------------------------------------------------------
# Local functions
# ------------------------------------------------------------------------------

function __global_configure
    # Abbreviations
    abbr fr       'find . -name "*.xml" -exec sed -i "s#toto#tata#g" "{}" \;'
    abbr fs       'find . -name "*.xml" -exec egrep -niH --color "toto" "{}" \;'

    abbr j        'jobs'
    abbr pg       'ps aux | grep'

    abbr c        'clear'
    abbr e        'exit'

    abbr g        'rg --smart-case --no-heading --sort path'
    abbr grep     'egrep'

    abbr l        'exa --group-directories-first -h -l'
    abbr m        'exa --group-directories-first -h -l'
    abbr ù        'exa --group-directories-first -h -l'
    abbr la       'exa --group-directories-first -h -l -a'

    abbr mkdir    'mkdir -p'

    abbr t        'tail -f'
    abbr make     'make -j4'
    abbr h        'history'

    abbr tree     'exa --group-directories-first --git -T -h -l'

    abbr untar    'tar xvf'

    abbr ee       'nvim'
    abbr see      'sudo -E nvim'

    abbr rm       'trash'

    abbr todo     'rg --smart-case --no-heading --sort path TODO'

    abbr reboot   'echo "No way !"'
    abbr poweroff   'echo "No way !"'
end

function __global_register
    set --local name 'global'

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

function global_init
    if not set --query __global_initialized
        set --universal __global_initialized

       __global_configure
    end
end

function global_reload
    set --erase __global_initialized
    global_init

    echo 'global_reload done'
end

# ------------------------------------------------------------------------------
# Entry point
# ------------------------------------------------------------------------------

__global_register
