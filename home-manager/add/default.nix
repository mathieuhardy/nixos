{ config, lib, pkgs, ... }:

let
  # Dependencies
  add = pkgs.callPackage ../../packages/add/add.nix {};

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      add = {
        enable = lib.mkEnableOption "add configuration";
      };
    };
  };

  # Enable packages if at least one user had enabled this module
  enablePackages = { username, ... }:
    lib.mkIf config.hm."${username}".add.enable {
      systemPackages = [
        add
      ];
    };

  # Enable dependencies if at least one user has enabled this module
  enableDependencies = { username, ... }: {
    "name" = username;
    "value" = lib.mkIf config.hm."${username}".add.enable {
      easier.enable = true;
    };
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

    hm = builtins.listToAttrs (map enableDependencies config.settings.users);
  };
}
