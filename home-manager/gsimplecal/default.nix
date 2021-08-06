{ config, lib, pkgs, ... }:

let
  # Helpers
  boolToString = value : if value then "1" else "0";

  # Variables
  configDir = ".config/gsimplecal";

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      gsimplecal = {
        enable = lib.mkEnableOption "gsimplecal configuration";

        clockFormat = lib.mkOption {
          type = lib.types.str;
          default = "%H:%M";
          description = ''
            Format used to display the clock.
          '';
        };

        clockLabel = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = ''
            Label of the clock.
          '';
        };

        clockTz = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = ''
            Timezone of the clock.
          '';
        };

        closeOnUnfocus = lib.mkEnableOption ''
          the close of the window when focus is lost
        '';

        forceLang = lib.mkOption {
          type = lib.types.str;
          default = "fr_FR.utf8";
          description = ''
            The language to be used.
          '';
        };

        mainWindowDecorated = lib.mkEnableOption "the decoration of the window";

        mainWindowKeepAbove = lib.mkEnableOption "the keep above function";

        mainWindowResizable = lib.mkEnableOption ''
          the resizability of the window
        '';

        mainWindowPosition = lib.mkOption {
          type = lib.types.str;
          default = "mouse";
          description = ''
            The position of the window. Possible values are: center, mouse and
            none.
          '';
        };

        mainWindowSticky = lib.mkEnableOption "the stickyness of the window";

        mainWindowSkipTaskbar = lib.mkEnableOption ''
          the skipping of the taskbar"
        '';

        mainWindowXOffset = lib.mkOption {
          type = lib.types.int;
          default = 0;
          description = ''
            X offset of the window.
          '';
        };

        mainWindowYOffset = lib.mkOption {
          type = lib.types.int;
          default = 0;
          description = ''
            Y offset of the window.
          '';
        };

        markToday = lib.mkEnableOption "highlight of the current day";

        showCalendar = lib.mkEnableOption "visibility of the calendar";

        showTimezones = lib.mkEnableOption "visibility of the timezones";

        showWeekNumbers = lib.mkEnableOption "visibility of the week numbers";
      };
    };
  };

  # Make per-user configuration
  makeUserConfiguration = { username, ... }:
    let
      cfg = config.hm."${username}".gsimplecal;
    in
    {
      "name" = username;
      "value" = lib.mkIf cfg.enable {
        # Tells to fire how it should toggle
        home.file.".config/fire/gsimplecal".source = ./resources/fire;

        # Configuration file
        home.file."${configDir}/config".text = ''
          clock_format = ${cfg.clockFormat}
          clock_label = ${cfg.clockLabel}
          clock_tz = ${cfg.clockTz}
          close_on_unfocus = ${boolToString cfg.closeOnUnfocus}
          force_lang = ${cfg.forceLang}
          mainwindow_decorated = ${boolToString cfg.mainWindowDecorated}
          mainwindow_keep_above = ${boolToString cfg.mainWindowKeepAbove}
          mainwindow_resizable = ${boolToString cfg.mainWindowResizable}
          mainwindow_position = ${cfg.mainWindowPosition}
          mainwindow_sticky = ${boolToString cfg.mainWindowSticky}
          mainwindow_skip_taskbar = ${boolToString cfg.mainWindowSkipTaskbar}
          mainwindow_xoffset = ${builtins.toString cfg.mainWindowXOffset}
          mainwindow_yoffset = ${builtins.toString cfg.mainWindowYOffset}
          mark_today = ${boolToString cfg.markToday}
          show_calendar = ${boolToString cfg.showCalendar}
          show_timezones = ${boolToString cfg.showTimezones}
          show_week_numbers = ${boolToString cfg.showWeekNumbers}
        '';
      };
    };

  # Enable packages if at least one user had enabled this module
  enablePackages = { username, ... }:
    lib.mkIf config.hm."${username}".gsimplecal.enable {
      systemPackages = [
        pkgs.gsimplecal
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
