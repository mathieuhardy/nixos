{ config, lib, pkgs, ... }:

let
  # Dependencies
  wallpapers = pkgs.callPackage ../../packages/wallpapers/wallpapers.nix {};

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      feh = {
        enable = lib.mkEnableOption "feh configuration";
      };
    };
  };

  # Make per-user configuration
  makeUserConfiguration = { username, ... }: {
    "name" = username;
    "value" = lib.mkIf config.hm."${username}".feh.enable {
      # Init scripts use by thirdparties
      home.file.".config/bspwm/init.d/feh".source = ./resources/init.d/feh;
    };
  };

  # Enable packages if at least one user had enabled this module
  enablePackages = { username, ... }:
    lib.mkIf config.hm."${username}".feh.enable {
      systemPackages = [
        pkgs.feh

        wallpapers
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

    home-manager.users =
      builtins.listToAttrs (map makeUserConfiguration config.settings.users);
  };
}
