# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

function fish-reload
    fish_load
end

function fish_load
    # Load helpers
    for file in $HOME/.config/fish/helpers/*.fish
        source $file
    end

    # Load plugins
    set --local config_dir ~/.config/fish/plugins

    for plugin in $(ls $config_dir)
        fish_plugin_register "$config_dir" "$plugin"
    end

    # load custom plugins
    set --local config_dir ~/.config/fish/custom_plugins

    if test -d $config_dir
        for plugin in $(ls $config_dir)
            fish_plugin_register "$config_dir" "$plugin"
        end
    end
end

# ------------------------------------------------------------------------------
# Entry point
# ------------------------------------------------------------------------------

set fish_greeting ''

fish_load
