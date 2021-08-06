{ ... }:

{
  # ----------------------------------------------------------------------------
  # Imports
  # ----------------------------------------------------------------------------

  imports = [
    # Shared
    ../shared/settings.nix

    # Hardware
    ../hardware/laptop.nix
    ../hardware/lenovo/thinkpad/p14s-gen1-amd.nix

    # Disks
    ../filesystems/oz

    # Home-manager
    ../home-manager

    # Users
    ../users/mhardy

    # Common configuration used by all users
    ../nixos
  ];

  # ----------------------------------------------------------------------------
  # Settings overrides
  # ----------------------------------------------------------------------------

  settings.autoLoginUser = "mhardy";

  # ----------------------------------------------------------------------------
  # Networking
  # ----------------------------------------------------------------------------

  networking.hostName = "oz";
}
