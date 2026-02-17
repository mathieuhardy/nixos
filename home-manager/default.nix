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
    ./fish.nix
    ./git.nix
    ./input-remapper.nix
    ./lsd.nix
    ./mpv.nix
    ./neovim.nix
    ./secrets.nix
    ./ssh.nix
    ./xdg.nix
    ./zed.nix
  ];

  # ────────────────────────────────────────────────────────────────────────────
  # Global home-manager configuration
  # ────────────────────────────────────────────────────────────────────────────

  home.username = "${osConfig.settings.userLogin}";
  home.homeDirectory = "/home/${osConfig.settings.userLogin}";

  home.stateVersion = lib.trivial.release;
}
