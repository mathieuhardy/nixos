{ config, lib, pkgs, ... }:

let
  # Dependencies
  battery = pkgs.callPackage ../../packages/battery-mode/battery-mode.nix {};
  cerebro = pkgs.callPackage ../../packages/cerebro/cerebro.nix {};
  fire = pkgs.callPackage ../../packages/fire/fire.nix {};
  utils = pkgs.callPackage ../../packages/polybar-utils/polybar-utils.nix {};

  launcher = "${pkgs.dpkg}/bin/start-stop-daemon";

  # Variables
  configDir = ".config/polybar";
  overridesPath = "${configDir}/.overrides";

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      polybar = {
        enable = lib.mkEnableOption "polybar configuration";

        theme = lib.mkOption {
          type = lib.types.str;
          default = "dark-colors";
          description = ''
            Name of the theme to install
          '';
          example = ''
            polybar.theme = "my-theme";
          '';
        };
      };
    };
  };

  # Make per-user configuration
  makeUserConfiguration = { username, ... }:
    let
      cfg = config.hm."${username}".polybar;

      commonOpts = "--quiet";

      startOpts = "--start ${commonOpts}" +
        " --make-pidfile" +
        " --background" +
        " --exec ${utils}/bin/poly-networks";

      stopOpts = "--stop ${commonOpts}" +
        " --signal TERM" +
        " --oknodo" +
        " --remove-pidfile";
    in
    {
      "name" = username;
      "value" = lib.mkIf cfg.enable {
        home.file."${configDir}/config".source = ./resources/config;
        home.file."${configDir}/themes".source = ./resources/themes;

        # Tells to fire how it should start and stop
        home.file.".config/fire/polybar".source = ./resources/fire;

        # Triggers for cerebro
        home.file.".config/cerebro/polybar.triggers".source =
          ./resources/cerebro/triggers;

        # Init scripts use by thirdparties
        home.file.".config/bspwm/init.d/polybar".source =
          ./resources/init.d/polybar;

        # Tells rice which theme to use
        home.file.".config/rice/polybar/theme.json".source =
          ./resources/themes + "/${cfg.theme}.json";

        # Polybar network monitoring
        systemd.user.services.poly-networks = {
          Unit = {
            Description = "Polybar network monitoring";
          };

          Install.WantedBy = [ "graphical-session.target" ];

          Service = {
            Type = "forking";

            Environment = "PATH=/run/current-system/sw/bin";

            ExecStart = "${launcher} ${startOpts}" +
              " --pidfile /tmp/pid/poly-networks.pid";

            ExecStop = "${launcher} ${stopOpts}" +
              " --pidfile /tmp/pid/poly-networks.pid";
          };
        };
      };
    };

  # Enable packages if at least one user had enabled this module
  enablePackages = { username, ... }:
    lib.mkIf config.hm."${username}".polybar.enable {
      systemPackages = [
        pkgs.blueman
        pkgs.brightnessctl
        pkgs.dpkg
        pkgs.imagemagick
        pkgs.mate.mate-system-monitor
        pkgs.pavucontrol
        pkgs.polybar
        pkgs.st
        pkgs.tdrop

        battery
        cerebro
        fire
        utils
      ];
    };

  # Enable dependencies if at least one user has enabled this module
  enableDependencies = { username, ... }: {
    "name" = username;
    "value" = lib.mkIf config.hm."${username}".polybar.enable {
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
