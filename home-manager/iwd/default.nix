{ config, lib, pkgs, ... }:

let
  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      iwd = {
        enable = lib.mkEnableOption "iwd configuration";
      };
    };
  };

  # Make networking configuration
  makeNetworkingConfiguration = { username, ... }:
    lib.mkIf config.hm."${username}".iwd.enable {
      networkmanager.wifi.backend = "iwd";

      wireless.iwd.enable = true;
    };

  # Make services configuration
  makeServicesConfiguration = { username, ... }:
    lib.mkIf config.hm."${username}".iwd.enable {
      connman.wifi.backend = "iwd";
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
    networking =
      lib.mkMerge (map makeNetworkingConfiguration config.settings.users);

    services =
      lib.mkMerge (map makeServicesConfiguration config.settings.users);
  };
}
