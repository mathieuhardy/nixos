function node_init
    # Install fish-node-manager
    if not type -q fnm
        curl -fsSL https://fnm.vercel.app/install | bash
    end
end
