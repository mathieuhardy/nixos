{ config, lib, pkgs, ... }:

let
  # Dependencies
  launcher = "${pkgs.dpkg}/bin/start-stop-daemon";

  # Helpers
  eitherStrBoolIntList = with lib.types;
    either str (either bool (either int (listOf str)));

  defaultSettings = {
    global = {
      monitor = 0;
      follow = "keyboard";
      geometry = "300x5-30+20";
      indicate_hidden = true;
      shrink = false;
      transparency = 0;
      notification_height = 0;
      separator_height = 0;
      padding = 8;
      horizontal_padding = 8;
      frame_width = 4;
      frame_color = "#e2e2e2";
      separator_color = "frame";
      sort = true;
      idle_threshold = 120;
      font = "DejaVu Sans Mono 9";
      line_height = 1;
      markup = "full";
      format = "<b>%s</b>\\n%b";
      alignment = "left";
      show_age_threshold = -1;
      word_wrap = true;
      ellipsize = "middle";
      ignore_newline = false;
      stack_duplicates = true;
      hide_duplicate_count = false;
      show_indicators = true;
      icon_position = "left";
      max_icon_size = 32;
      sticky_history = true;
      history_length = 20;
      dmenu = "/usr/bin/dmenu -p dunst:";
      browser = "/usr/bin/firefox -new-tab";
      always_run_script = true;
      title = "Dunst";
      class = "Dunst";
      startup_notification = false;
      verbosity = "mesg";
      corner_radius = 5;
      force_xinerama = false;
      mouse_left_click = "close_current";
      mouse_middle_click = "do_action";
      mouse_right_click = "close_all";
    };

    experimental = {
      per_monitor_dpi = false;
    };

    shortcuts = {
      close = "ctrl+space";
      close_all = "ctrl+shift+space";
      history = "ctrl+twosuperior";
      context = "ctrl+shift+period";
    };

    urgency_low = {
      background = "#272727";
      foreground = "#bbbbbb";
      frame_color = "#ffffff";
      timeout = 10;
    };

    urgency_normal = {
      background = "#272727";
      foreground = "#ffffff";
      frame_color = "#ffffff";
      timeout = 10;
    };

    urgency_critical = {
      background = "#900000";
      foreground = "#ffffff";
      frame_color = "#ffffff";
      timeout = 0;
    };
  };

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      dunst = {
        enable = lib.mkEnableOption "dunst configuration";

        settings = lib.mkOption {
          type = with lib.types; attrsOf (attrsOf eitherStrBoolIntList);
          default = defaultSettings;
          description = ''
            Settings to be applied to dunst (see dunst's official documentation
            for all available settings).
          '';
          example = ''
            dunst.settings = {
              global = {
                ...
              };
            };
          '';
        };

        pidFile = lib.mkOption {
          type = lib.types.str;
          default = "/tmp/pid/dunst";
          description = ''
            Path of the file used to store the PID of the daemon.
          '';
          example = ''
            dunst.pidFile = "/tmp/dunst.pid";
          '';
        };
      };
    };
  };

  # Make per-user configuration
  makeUserConfiguration = { username, ... }:
    let
      cfg = config.hm."${username}".dunst;

      commonOpts = "--quiet --pidfile ${cfg.pidFile}";

      startOpts = "--start ${commonOpts}" +
        " --make-pidfile" +
        " --background" +
        " --exec ${pkgs.dunst}/bin/dunst";

      stopOpts = "--stop ${commonOpts}" +
        " --signal TERM" +
        " --oknodo" +
        " --remove-pidfile";
    in
    {
      "name" = username;
      "value" = lib.mkIf cfg.enable {
        services.dunst = {
          enable = true;
          settings = cfg.settings;
        };

        # Override the home-manager configuration that uses Dbus
        systemd.user.services.dunst = lib.mkForce {
          Unit = {
            Description = "Dunst service";
          };

          Install.WantedBy = [ "graphical-session.target" ];

          Service = {
            Type = "forking";

            ExecStart = "${launcher} ${startOpts}";
            ExecStop = "${launcher} ${stopOpts}";
          };
        };
      };
  };

  # Enable packages if at least one user had enabled this module
  enablePackages = { username, ... }:
    lib.mkIf config.hm."${username}".dunst.enable {
      systemPackages = [
        pkgs.dpkg
        pkgs.dunst
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
