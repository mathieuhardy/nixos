{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { };

  # Custom packages
  loglit = pkgs.callPackage ./custom-packages/loglit.nix { };
in
{
  # ────────────────────────────────────────────────────────────────────────────
  # System packages
  # ────────────────────────────────────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    # Android
    libmtp
    gvfs

    # Development
    cargo
    cargo-llvm-cov
    cargo-nextest
    clang
    dbeaver-bin
    devcontainer
    fnm
    gitg
    go
    meld
    nodejs
    oxker # Docker TUI
    python3
    rustc
    rustup
    tokei
    zed-editor

    # Internet
    google-chrome
    protonvpn-gui
    vivaldi

    # Multimedia
    gthumb # Image viewer
    mpv
    qbittorrent
    shotcut # Video editor
    vlc

    # Office
    calibre # Ebooks
    eloquent # Spell checker
    libreoffice-qt

    # Security
    steghide # for tomb exhume
    tomb

    # System utilities
    age # For secrets encryption in NixOS configuration
    bash
    bottom
    curl
    fd
    input-remapper
    kdePackages.spectacle # Screenshots
    loglit # Logs highlighting
    lsd
    qalculate-qt
    ripgrep
    sops # For secrets encryption in NixOS configuration
    starship
    trashy
    unzip
    wget
    wezterm
    xarchiver
    xdg-user-dirs
    zip

    # Themes
    arc-theme
    arc-kde-theme
    kdePackages.qtstyleplugin-kvantum
    papirus-icon-theme
  ];

  # ────────────────────────────────────────────────────────────────────────────
  # Programs (with configuration possibility)
  # ────────────────────────────────────────────────────────────────────────────

  # Development
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Gaming
  programs.steam.enable = true;

  # System utilities
  programs.bash.enable = true;
  programs.bat.enable = true;
  programs.evince.enable = true;
  programs.fish.enable = true;

  programs.nix-ld = {
    # For thunar to be able to save settings
    enable = true;
    libraries = [ ];
  };

  programs.partition-manager.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin # zip/unzip
      thunar-volman # mount volumes
    ];
  };
}
