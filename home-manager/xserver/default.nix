{ config, lib, ... }:

let
  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      xserver = {
        enable = lib.mkEnableOption "xserver configuration";

        applicationsMenu = lib.mkOption {
          type = lib.types.str;
          description = "Command to open application menu";
          default = "";
        };

        webBrowser = lib.mkOption {
          type = lib.types.str;
          description = "Command to open web browser";
          default = "";
        };

        editor = lib.mkOption {
          type = lib.types.str;
          description = "Command to open text editor";
          default = "";
        };

        fileManager = lib.mkOption {
          type = lib.types.str;
          description = "Command to open file manager";
          default = "";
        };

        locker = lib.mkOption {
          type = lib.types.str;
          description = "Command to run session locker";
          default = "";
        };

        powerMenu = lib.mkOption {
          type = lib.types.str;
          description = "Command to open the power menu";
          default = "";
        };

        terminal = lib.mkOption {
          type = lib.types.str;
          description = "Command to open a new terminal";
          default = "";
        };

        runInTerminal = lib.mkOption {
          type = lib.types.str;
          description = "Command to run a command in terminal";
          default = "";
        };

        volumeControl = lib.mkOption {
          type = lib.types.str;
          description = "Command to open volume control";
          default = "";
        };

        wallpaper = lib.mkOption {
          type = lib.types.str;
          description = "Name of the wallpaper";
          default = "";
        };

        windowManager = {
          name = lib.mkOption {
            type = lib.types.str;
            description = "Name of the window manager";
            default = "";
          };

          reload = lib.mkOption {
            type = lib.types.str;
            description = "Command to reload the window manager";
            default = "";
          };

          kill = lib.mkOption {
            type = lib.types.str;
            description = "Command to kill the window manager";
            default = "";
          };
        };
      };
    };
  };

  # Make per-user configuration
  makeUserConfiguration = { username, ... }:
    let
      cfg = config.hm."${username}".xserver;
    in
    {
      "name" = username;
      "value" = lib.mkIf cfg.enable {
        home.file.".xprofile".source = ./resources/xprofile;

        home.file.".config/X11/xprofile.d/00_env".text = ''
          #!/usr/bin/env bash

          export APP_MENU="${cfg.applicationsMenu}"
          export EDITOR="${cfg.editor}"
          export FILE_MANAGER="${cfg.fileManager}"
          export LOCKER="${cfg.locker}"
          export POWER_MENU="${cfg.powerMenu}"
          export RUN_IN_TERMINAL="${cfg.runInTerminal}"
          export TERMINAL="${cfg.terminal}"
          export VOLUME_CONTROL="${cfg.volumeControl}"
          export WALLPAPER="${cfg.wallpaper}"
          export WEB_BROWSER="${cfg.webBrowser}"
          export WM="${cfg.windowManager.name}"
          export WM_RELOAD="${cfg.windowManager.reload}"
          export WM_KILL="${cfg.windowManager.kill}"
        '';

        # Init scripts use by thirdparties
        home.file.".config/bspwm/init.d/xsetroot".source =
          ./resources/init.d/xsetroot.sh;
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
    home-manager.users =
      builtins.listToAttrs (map makeUserConfiguration config.settings.users);
  };
}
