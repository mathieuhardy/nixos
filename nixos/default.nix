{ config, ... }:

{
  # ----------------------------------------------------------------------------
  # Imports
  # ----------------------------------------------------------------------------

  imports = [
    ./audio.nix
    ./fonts.nix
    ./internationalization.nix
    ./networking.nix
    ./packages.nix
    ./security.nix
    ./users.nix

    ./services
  ];

  # ----------------------------------------------------------------------------
  # System
  # ----------------------------------------------------------------------------

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "${config.settings.version}";
}
