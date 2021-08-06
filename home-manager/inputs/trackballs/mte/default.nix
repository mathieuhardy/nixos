{ config, lib, ... }:

let
  # Variables
  name = "Microsoft Microsoft Trackball Explorer®";

  configDir = ".config/X11/xprofile.d";

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      mte = {
        enable = lib.mkEnableOption "MTE configuration";

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

        fn1 = lib.mkOption {
          type = lib.types.int;
          description = "Action to be binded on this button";
          default = 8;
        };

        fn2 = lib.mkOption {
          type = lib.types.int;
          description = "Action to be binded on this button";
          default = 9;
        };

        speed = lib.mkOption {
          type = lib.types.str;
          description = "Speed of the mouse";
          default = "0.0";
        };
      };
    };
  };

  # Make per-user configuration
  makeUserConfiguration = { username, ... }:
    let
      cfg = config.hm."${username}".mte;

      mapping = "${builtins.toString cfg.left} " +
        "${builtins.toString cfg.middle} " +
        "${builtins.toString cfg.right} " +
        "${builtins.toString cfg.wheelUp} " +
        "${builtins.toString cfg.wheelDown} " +
        "6 7 " +
        "${builtins.toString cfg.fn1} " +
        "${builtins.toString cfg.fn2} " +
        "10 11";
    in
    {
      "name" = username;
      "value" = lib.mkIf cfg.enable {
        home.file."${configDir}/01_run_mte".text = ''
          #!/usr/bin/env sh

          if command -v xinput > /dev/null
          then
              plugged=$(xinput list | grep "${name}")

              if [ -n "''${plugged}" ]
              then
                  xinput set-button-map "${name}" ${mapping}
                  xinput set-prop "${name}" "libinput Accel Speed" ${cfg.speed}
              fi
          fi
        '';
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
