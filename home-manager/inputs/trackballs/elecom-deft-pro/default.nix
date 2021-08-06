{ config, lib, pkgs, ... }:

# TODO: xdotool (.xbindkeysrc)
#   Up and down buttons
#   "xdotool key --clearmodifiers 'Prior'"
#     b:9

#   "xdotool key --clearmodifiers 'Next'"
#     b:8

#   Left and right wheel buttons
#   "xdotool key --clearmodifiers 'Control_L+Prior'"
#     b:6

#   "xdotool key --clearmodifiers 'Control_L+Next'"
#     b:7

# Fn3 button
#   "xdotool getactivewindow key --clearmodifiers 'Control_L+w'"
#   b:12

let
  # Variables
  name = "ELECOM TrackBall Mouse DEFT Pro TrackBall Mouse";

  configDir = ".config/X11/xprofile.d";

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      elecomDeftPro = {
        enable = lib.mkEnableOption "Elecom DEFT Pro configuration";

        left = lib.mkOption {
          type = lib.types.int;
          description = "Action to be binded on this button";
          default = 1;
        };

        middle = lib.mkOption {
          type = lib.types.int;
          description = "Action to be binded on this button";
          default = 2;
        };

        right = lib.mkOption {
          type = lib.types.int;
          description = "Action to be binded on this button";
          default = 3;
        };

        wheelUp = lib.mkOption {
          type = lib.types.int;
          description = "Action to be binded on this button";
          default = 4;
        };

        wheelDown = lib.mkOption {
          type = lib.types.int;
          description = "Action to be binded on this button";
          default = 5;
        };

        wheelLeft = lib.mkOption {
          type = lib.types.int;
          description = "Action to be binded on this button";
          default = 6;
        };

        wheelRight = lib.mkOption {
          type = lib.types.int;
          description = "Action to be binded on this button";
          default = 7;
        };

        down = lib.mkOption {
          type = lib.types.int;
          description = "Action to be binded on this button";
          default = 8;
        };

        up = lib.mkOption {
          type = lib.types.int;
          description = "Action to be binded on this button";
          default = 9;
        };

        # Button at right of the ball
        fn1 = lib.mkOption {
          type = lib.types.int;
          description = "Action to be binded on this button";
          default = 10;
        };

        # Button at the most right position
        fn2 = lib.mkOption {
          type = lib.types.int;
          description = "Action to be binded on this button";
          default = 11;
        };

        # Button above left click
        fn3 = lib.mkOption {
          type = lib.types.int;
          description = "Action to be binded on this button";
          default = 13;
        };
      };
    };
  };

  # Make per-user configuration
  makeUserConfiguration = { username, ... }:
    let
      cfg = config.hm."${username}".elecomDeftPro;

      mapping = "${builtins.toString cfg.left} " +
        "${builtins.toString cfg.middle} " +
        "${builtins.toString cfg.right} " +
        "${builtins.toString cfg.wheelUp} " +
        "${builtins.toString cfg.wheelDown} " +
        "${builtins.toString cfg.wheelLeft} " +
        "${builtins.toString cfg.wheelRight} " +
        "${builtins.toString cfg.down} " +
        "${builtins.toString cfg.up} " +
        "${builtins.toString cfg.fn1} " +
        "${builtins.toString cfg.fn2} " +
        "${builtins.toString cfg.fn3}";
    in
    {
      "name" = username;
      "value" = lib.mkIf cfg.enable {
        home.file."${configDir}/01_run_deft_pro".text = ''
          #!/usr/bin/env sh

          if command -v xinput > /dev/null
          then
              plugged=$(xinput list | grep "${name}")

              if [ -n "''${plugged}" ]
              then
                  xinput set-button-map "${name}" ${mapping}
              fi
          fi
        '';
      };
    };

  # Enable packges if at least one user had enabled this module
  enablePackages = { username, ... }:
    lib.mkIf config.hm."${username}".elecomDeftPro.enable {
      systemPackages = [
        pkgs.xdotool
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
