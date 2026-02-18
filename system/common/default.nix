{ config, lib, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Imports
  # ────────────────────────────────────────────────────────────────────────────

  imports = [
    ./audio
    ./bluetooth
    ./boot
    ./filesystem
    ./fonts
    ./garbage-collector
    ./i18n
    ./inputs
    ./networking
    ./openssh
    ./printing
    ./security
    ./users

    ./packages.nix
  ];
}
