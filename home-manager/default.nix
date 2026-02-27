{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Imports
  # ────────────────────────────────────────────────────────────────────────────

  imports = [
    ./alacritty.nix
    ./bat.nix
    ./firefox.nix
    ./fish.nix
    ./git.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./input-remapper.nix
    ./lsd.nix
    ./mpv.nix
    ./neovim.nix
    ./nwg-bar.nix
    ./secrets.nix
    ./ssh.nix
    ./swaybg.nix
    ./swayimg.nix
    ./swaync.nix
    ./swayosd.nix
    ./theme.nix
    ./walker.nix
    ./waybar.nix
    ./xdg.nix
    ./zed.nix
  ];

  # ────────────────────────────────────────────────────────────────────────────
  # Global home-manager configuration
  # ────────────────────────────────────────────────────────────────────────────

  home.username = "${osConfig.settings.userLogin}";
  home.homeDirectory = "/home/${osConfig.settings.userLogin}";

  home.stateVersion = osConfig.settings.stateVersion;
}
