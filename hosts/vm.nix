{ config, ... }:

{
  # ----------------------------------------------------------------------------
  # Imports
  # ----------------------------------------------------------------------------

  imports = [
    # Shared
    ../shared/settings.nix

    # Home-manager
    ../home-manager

    # Users
    ../users/demo
    ../users/guest

    # Common configuration used by all users
    ../nixos/audio.nix
    ../nixos/fonts.nix
    ../nixos/internationalization.nix
    ../nixos/networking.nix
    ../nixos/packages.nix
    ../nixos/security.nix
    ../nixos/users.nix

    ../nixos/services/xserver.nix
  ];

  # ----------------------------------------------------------------------------
  # Settings overrides
  # ----------------------------------------------------------------------------

  #settings.autoLoginUser = "demo";

  # ----------------------------------------------------------------------------
  # System
  # ----------------------------------------------------------------------------

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "${config.settings.version}";
}
