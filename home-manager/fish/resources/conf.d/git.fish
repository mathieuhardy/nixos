################################################################################
#
# Script name: git.fish
# Description: Fish configuration for git.
# Dependencies:
# GitHub: https://www.github.com/mathieuhardy/nixos
# License: https://www.github.com/mathieuhardy/nixos/LICENSE
# Contributors: Mathieu Hardy
#
################################################################################

# ------------------------------------------------------------------------------
# Local functions
# ------------------------------------------------------------------------------

function __git_configure
    # Abbreviations
    abbr clone      'git clone'

    abbr fetch      'git fetch'
    abbr pull       'git pull --rebase'
    abbr push       'git push'
    abbr pushf      'git push --force'

    abbr ci          'git commit'
    abbr amend       'git commit --amend'
    abbr co          'git checkout'
    abbr hard        'git reset --hard'
    abbr rebase      'git rebase'

    abbr merge       'git merge'
    abbr mergetool   'git mergetool -t meld'

    abbr st          'git status'
    abbr br          'git branch'
    abbr di          'git difftool -y -t meld'
    abbr gld         'git log --oneline --decorate'
    abbr glg         ''\
'git log'\
" --pretty=format:'%C(yellow)[%H]%Creset %C(green)[%ai] %C(blue)[%an]%Creset"\
" - %s' --abbrev-commit"

    abbr pop         'git stash pop'
    abbr stash       'git stash'

    abbr submodule   'git submodule update --init --recursive'

    abbr fixup       'git commit --fixup'
    abbr squash      'git rebase -i --autosquash'

    abbr gg          'gitg --all&'
end

function __git_register
    set --local name 'git'

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

function git_init
    if not set --query __git_initialized
        set --universal __git_initialized

       __git_configure
    end
end

function git_reload
    set --erase __git_initialized
    git_init

    echo 'git_reload done'
end

# ------------------------------------------------------------------------------
# Entry point
# ------------------------------------------------------------------------------

__git_register
