{ config, lib, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Imports
  # ────────────────────────────────────────────────────────────────────────────

  imports = [
    ./common

    ./hyprland
    # TODO: remove
    # ./kde
    ./xserver
  ];

  # ────────────────────────────────────────────────────────────────────────────
  # System
  # ────────────────────────────────────────────────────────────────────────────

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Global version
  system.stateVersion = lib.trivial.release;
}
