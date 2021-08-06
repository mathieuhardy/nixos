{ config, lib, pkgs, ... }:

let
  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      lightdm = {
        enable = lib.mkEnableOption "lightdm configuration";
      };
    };
  };

  # Make services configuration
  makeServicesConfiguration = { username, ... }:
    lib.mkIf config.hm."${username}".lightdm.enable {
      xserver.displayManager.lightdm = {
        enable = true;
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
  };
}
