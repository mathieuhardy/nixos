{ config, lib, pkgs, ... }:

let
  # Dependencies
  override = pkgs.callPackage ../../packages/override/override.nix {};

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      override = {
        enable = lib.mkEnableOption "override configuration";
      };
    };
  };

  # Enable packages if at least one user had enabled this module
  enablePackages = { username, ... }:
    lib.mkIf config.hm."${username}".override.enable {
      systemPackages = [
        override
      ];
    };
in
{
  # ----------------------------------------------------------------------------
  # Options
  # ----------------------------------------------------------------------------

  options.hm = builtins.listToAttrs (map makeUserOptions config.settings.users);

  # ----------------------------------------------------------------------------
  # Configuration
  # ----------------------------------------------------------------------------

  config = {
    environment = lib.mkMerge (map enablePackages config.settings.users);
  };
}
