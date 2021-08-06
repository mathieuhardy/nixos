{ config, lib, pkgs, ... }:

let
  # Dependencies
  rice = pkgs.callPackage ../../packages/rice/rice.nix {};

  # Variables
  configDir = ".config/rice";

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      rice = {
        enable = lib.mkEnableOption "rice configuration";
      };
    };
  };

  # Enable packages if at least one user had enabled this module
  enablePackages = { username, ... }:
    lib.mkIf config.hm."${username}".rice.enable {
      systemPackages = [
        pkgs.jq

        rice
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
