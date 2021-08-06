{ config, lib, pkgs, ... }:

let
  # Dependencies
  utils = pkgs.callPackage ../../packages/rofi-utils/rofi-utils.nix {};

  # Variables
  configDir = ".config/rofi";

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      rofi = {
        enable = lib.mkEnableOption "rofi configuration";

        theme = lib.mkOption {
          type = lib.types.str;
          default = "dark";
          description = ''
            Name of the theme to use.
          '';
          example = ''
            rofi.theme = "my-theme";
          '';
        };
      };
    };
  };

  # Make per-user configuration
  makeUserConfiguration = { username, ... }:
    let
      cfg = config.hm."${username}".rofi;
    in
    {
      "name" = username;
      "value" = lib.mkIf cfg.enable {
        # Install all themes
        home.file."${configDir}/clean.rasi".source = ./resources/clean.rasi;
        home.file."${configDir}/dark.rasi".source = ./resources/dark.rasi;
        home.file."${configDir}/slate.rasi".source = ./resources/slate.rasi;

        # Configuration entry point
        home.file."${configDir}/config.rasi".text= ''
          configuration {
            modi: "window,run,ssh,drun";
            theme: "${cfg.theme}";
          }
        '';
      };
    };

  # Enable packages if at least one user had enabled this module
  enablePackages = { username, ... }:
    lib.mkIf config.hm."${username}".rofi.enable {
      systemPackages = [
        pkgs.rofi

        utils
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
