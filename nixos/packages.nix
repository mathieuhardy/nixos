{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in
{
  # ----------------------------------------------------------------------------
  # System packages
  # ----------------------------------------------------------------------------

  environment.systemPackages = with pkgs; [
    bash
    cryptsetup
    gparted
    htop
    libnotify
    lm_sensors
    meld
    nix-prefetch-scripts
    openssl
    python3
    trash-cli
    unstable.firefox
    unzip
    zip
    wget
  ];
}
