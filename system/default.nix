{ config, lib, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Imports
  # ────────────────────────────────────────────────────────────────────────────

  imports = [
    ./common
    ./hyprland
    ./xserver
  ];

  # ────────────────────────────────────────────────────────────────────────────
  # System
  # ────────────────────────────────────────────────────────────────────────────

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Global version
  system.stateVersion = config.settings.stateVersion;
}
