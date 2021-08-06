{ config, lib, pkgs, ... }:

let
  # Variables
  configDir = ".config/xfce4/xconf/xfce-perchannel-xml";

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      thunar = {
        enable = lib.mkEnableOption "thunar configuration";

        plugins = {
          archive = lib.mkEnableOption "the archive plugin";
        };
      };
    };
  };

  # Make per-user configuration
  makeUserConfiguration = { username, ... }: {
    "name" = username;
    "value" = lib.mkIf config.hm."${username}".thunar.enable {
      home.file."${configDir}/thunar.xml".source = ./resources/thunar.xml;
    };
  };

  # Enable packages if at least one user had enabled this module
  enablePackages = { username, ... }: lib.mkMerge [
    (lib.mkIf config.hm."${username}".thunar.enable {
      systemPackages = [
        pkgs.xfce.thunar
      ];
    })

    (lib.mkIf config.hm."${username}".thunar.plugins.archive {
      systemPackages = [
        pkgs.xfce.thunar-archive-plugin
      ];
    })
  ];
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
