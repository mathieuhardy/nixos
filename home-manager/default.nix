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
    ./fish.nix
    ./git.nix
    ./hypridle.nix
    ./input-remapper.nix
    ./lsd.nix
    ./mpv.nix
    ./neovim.nix
    ./secrets.nix
    ./ssh.nix
    ./theme.nix
    ./waybar.nix
    ./xdg.nix
    ./zed.nix
  ];

  # TODO: move to dedicated file
  # Filter some entries in sherlock:
  #   - thunar
  xdg.configFile."sherlock/sherlockignore".text = ''
    Bulk rename
    Removable Drives and Media
    Thunar Preferences
  '';

  # ────────────────────────────────────────────────────────────────────────────
  # Global home-manager configuration
  # ────────────────────────────────────────────────────────────────────────────

  home.username = "${osConfig.settings.userLogin}";
  home.homeDirectory = "/home/${osConfig.settings.userLogin}";

  home.stateVersion = osConfig.settings.stateVersion;
}
