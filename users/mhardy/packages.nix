{ pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in
{
  # ----------------------------------------------------------------------------
  # Overlays
  # ----------------------------------------------------------------------------

  nixpkgs.overlays = [
    (self: super: {
      polybar = super.polybar.overrideAttrs (old: {
        patches = (old.patches or []) ++ [
          ./patches/polybar/01-ipc-hanging-getline.patch
        ];
      });
    })
  ];

  # ----------------------------------------------------------------------------
  # System packages
  # ----------------------------------------------------------------------------

  environment.systemPackages = with pkgs; [
    bat
    bless
    cargo
    chromium
    clang
    ctags
    dia
    exa
    fd
    #feedreader
    fzf
    git-lfs
    gitg
    gnome3.adwaita-icon-theme
    gucharmap
    kcalc
    neofetch
    networkmanagerapplet
    playerctl
    #python37Packages.glances
    #qownnotes
    ripgrep
    shellcheck
    silver-searcher
    sysstat
    typora
    tusk
    unstable.mkchromecast
  ];
}
