function devcontainer_init
    # Install devcontainer CLI
    if not type -q devcontainer
        sudo npm install -g @devcontainers/cli@latest 1>/dev/null
    end

    # Build / rebuild
    abbr db     "devcontainer build --workspace-folder ."
    abbr dbnc   "devcontainer build --remove-existing-container --build-no-cache --workspace-folder ."

    # Up / down
    abbr dstart "devcontainer up --workspace-folder ."
    abbr dup    "devcontainer up --workspace-folder ."
    abbr dstop  'docker stop $(docker ps -a -q)'
    abbr ddown  'docker stop $(docker ps -a -q)'

    # Connect
    abbr dsh    "devcontainer exec --workspace-folder . /bin/bash"

    # Clean
    abbr dprune "docker image prune -a && docker builder prune -a"
end
