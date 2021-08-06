{ config, lib, pkgs, ... }:

let
  # Dependencies
  lok = pkgs.callPackage ../../packages/lok/lok.nix {};
  wallpapers = pkgs.callPackage ../../packages/wallpapers/wallpapers.nix {};

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      lok = {
        enable = lib.mkEnableOption "lok configuration";

        theme = lib.mkOption {
          type = lib.types.str;
          default = "black-and-white";
          description = ''
            Name of the theme to be used (without file extension).
          '';
          example = ''
           lok.theme = "my-theme"; # my-theme.sh will be installed
          '';
        };
      };
    };
  };

  # Make per-user configuration
  makeUserConfiguration = { username, ... }:
    let
      cfg = config.hm."${username}".lok;

      configDir = ".config/lok";
    in
    {
      "name" = username;
      "value" = lib.mkIf cfg.enable {
        # Install all themes (to be able to use theme without rebuilding the
        # entire system).
        home.file."${configDir}/themes".source = ./resources/themes;

        # Tells rice which theme to use
        home.file.".config/rice/lok/theme.sh".source =
          ./resources/themes + "/${cfg.theme}.sh";
      };
    };

  # Enable packages if at least one user had enabled this module
  enablePackages = { username, ... }:
    lib.mkIf config.hm."${username}".lok.enable {
      systemPackages = [
        pkgs.i3lock-color
        pkgs.xorg.xdpyinfo

        lok
        wallpapers
      ];
    };

  # Enable dependencies if at least one user has enabled this module
  enableDependencies = { username, ... }: {
    "name" = username;
    "value" = lib.mkIf config.hm."${username}".lok.enable {
      rice.enable = true;
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
    environment = lib.mkMerge (map enablePackages config.settings.users);

    hm = builtins.listToAttrs (map enableDependencies config.settings.users);

    home-manager.users =
      builtins.listToAttrs (map makeUserConfiguration config.settings.users);
  };
}
