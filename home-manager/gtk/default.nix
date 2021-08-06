{ config, lib, pkgs, ... }:

let
  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      gtk = {
        enable = lib.mkEnableOption "gtk configuration";
      };
    };
  };

  # Make per-user configuration
  makeUserConfiguration = { username, ... }: {
    "name" = username;
    "value" = lib.mkIf config.hm."${username}".gtk.enable {
      gtk.enable = true;
    };
  };

  # Enable packages if at least one user had enabled this module
  enablePackages = { username, ... }:
    lib.mkIf config.hm."${username}".gtk.enable {
      systemPackages = [
        pkgs.dconf
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
