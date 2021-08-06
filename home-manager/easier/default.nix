{ config, lib, pkgs, ... }:

let
  # Dependencies
  easier = pkgs.callPackage ../../packages/easier/easier.nix {};

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      easier = {
        enable = lib.mkEnableOption "easier configuration";
      };
    };
  };

  # Enable packages if at least one user had enabled this module
  enablePackages = { username, ... }:
    lib.mkIf config.hm."${username}".easier.enable {
      systemPackages = [
        easier
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
