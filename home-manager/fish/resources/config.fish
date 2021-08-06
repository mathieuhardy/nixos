# ==============================================================================
#
# Script name: config.fish
# Description: Configuration loaded by fish at startup.
# Dependencies:
# GitHub: https://www.github.com/mathieuhardy/nixos
# License: https://www.github.com/mathieuhardy/nixos/LICENSE
# Contributors: Mathieu Hardy
#
# ==============================================================================

# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

function fish-reload
    # Re-source configurations
    for file in $HOME/.config/fish/conf.d/*.fish
        source $file
    end

    # Reload modules
    for module in $__fish_modules
        if string length --quiet $module
            eval (string join '' $module '_reload')
        end
    end
end

function fish-add-user-path
    if ! set --query fish_user_paths
        set --universal fish_user_paths ''
    end

    if ! string match -q -- $argv $fish_user_paths
        set --append fish_user_paths $argv
    end
end

# ------------------------------------------------------------------------------
# Entry point
# ------------------------------------------------------------------------------

# Initialize all modules
for module in $__fish_modules
    if string length --quiet $module
        eval (string join '' $module '_init')
    end
end
