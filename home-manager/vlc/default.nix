{ config, lib, pkgs, ... }:

# TODO: add skin

let
  # Variables
  configDir = ".config/vlc";

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      vlc = {
        enable = lib.mkEnableOption "vlc configuration";
      };
    };
  };

  # Make per-user configuration
  makeUserConfiguration = { username, ... }: {
    "name" = username;
    "value" = lib.mkIf config.hm."${username}".vlc.enable {
      home.file."${configDir}/vlcrc".source = ./resources/vlcrc;
    };
  };

  # Enable packages if at least one user had enabled this module
  enablePackages = { username, ... }:
    lib.mkIf config.hm."${username}".vlc.enable {
      systemPackages = [
        pkgs.vlc
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
