function rust_init
    # Setup tools
    rust_install 1

    # Env
    fish_add_path $HOME/.cargo/bin

    # Abbrevations
    abbr build "cargo build --release"
    abbr run "cargo run --release"
    abbr clippy "cargo clippy --workspace --all-targets --all-features -- -D warnings"
end
