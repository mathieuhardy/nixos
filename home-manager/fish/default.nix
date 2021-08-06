{ config, lib, pkgs, ... }:

let
  # Variables
  configDir = ".config/fish";

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      fish = {
        enable = lib.mkEnableOption "fish configuration";
      };
    };
  };

  # Make per-user configuration
  makeUserConfiguration = { username, ... }: {
    "name" = username;
    "value" = lib.mkIf config.hm."${username}".fish.enable {
      home.file."${configDir}/config.fish".source = ./resources/config.fish;
      home.file."${configDir}/conf.d".source = ./resources/conf.d;
      home.file."${configDir}/functions".source = ./resources/functions;
    };
  };

  # Enable packages if at least one user had enabled this module
  enablePackages = { username, ... }:
    lib.mkIf config.hm."${username}".fish.enable {
      systemPackages = [
        pkgs.fish
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
