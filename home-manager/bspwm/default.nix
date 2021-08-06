{ config, lib, pkgs, ... }:

let
  # Variables
  configDir = ".config/bspwm";

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      bspwm = {
        enable = lib.mkEnableOption "bspwm configuration";
      };
    };
  };

  # Make per-user configuration
  makeUserConfiguration = { username, name, email, ... }: {
    "name" = username;
    "value" = lib.mkIf config.hm."${username}".bspwm.enable {
      home.file."${configDir}/bspwmrc".source = ./resources/bspwmrc;
    };
  };

  # Make services configuration
  makeServicesConfiguration = { username, ... }:
    lib.mkIf config.hm."${username}".bspwm.enable {
      xserver = {
        windowManager.bspwm.enable = true;
        displayManager.defaultSession = "none+bspwm";
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
    services =
      lib.mkMerge (map makeServicesConfiguration config.settings.users);

    home-manager.users =
      builtins.listToAttrs (map makeUserConfiguration config.settings.users);
  };
}
