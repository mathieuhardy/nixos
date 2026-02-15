{ config, lib, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Imports
  # ────────────────────────────────────────────────────────────────────────────

  imports = [
    ./audio.nix
    ./boot.nix
    ./fonts.nix
    ./garbage-collector.nix
    ./i18n.nix
    ./networking.nix
    ./packages.nix
    ./security.nix
    ./users.nix

    ./services
  ];

  # ────────────────────────────────────────────────────────────────────────────
  # System
  # ────────────────────────────────────────────────────────────────────────────

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Global version
  system.stateVersion = lib.trivial.release;
}
