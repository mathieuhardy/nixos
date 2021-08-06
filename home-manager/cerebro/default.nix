{ config, lib, pkgs, ... }:

let
  # Dependencies
  cerebro = pkgs.callPackage ../../packages/cerebro/cerebro.nix {};

  fusermount = "/run/wrappers/bin/fusermount";
  mkdir = "/run/current-system/sw/bin/mkdir";

  # Helpers
  boolToString = value : if value then "true" else "false";

  # Variables
  configDir = ".config/cerebro";

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      cerebro = {
        # Global options
        enable = lib.mkEnableOption "cerebro configuration";

        mountPoint = lib.mkOption {
          type = lib.types.str;
          default = "/tmp/cerebro";
          description = ''
            Path where the use filesystem should be mounted.
          '';
          example = ''
            cerebro.mountPoint = "/mnt/mountpoint";
          '';
        };

        logFile = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = ''
            Path of the file where the logs should be written. If no path is
            provided, then logs will be dumped to stdout by default.
            '';
          example = ''
            cerebro.logFile = "/tmp/cerebro.log";
          '';
        };

        # CPU module
        cpu = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = ''
              Toggle used to enable/disable the CPU module. This module provides
              information about CPU usage and temperature.
            '';
            example = ''
              cerebro.cpu.enable = true;
            '';
          };

          timeout = lib.mkOption {
            type = lib.types.int;
            default = 3;
            description = ''
              Delay in seconds for the refresh of the module's data.
            '';
            example = ''
              cerebro.cpu.timeout = 1;
            '';
          };

          json = {
            enable = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = ''
                Toggle used to enable/disable the Json export for the CPU
                module.
              '';
              example = ''
                cerebro.cpu.json.enable = true;
              '';
            };
          };

          shell = {
            enable = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = ''
                Toggle used to enable/disable the shell export for the CPU
                module.
              '';
              example = ''
                cerebro.cpu.shell.enable = true;
              '';
            };
          };
        };

        # Battery module
        battery = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = ''
              Toggle used to enable/disable the battery module. This module
              provides information about the battery level and its power status.
            '';
            example = ''
              cerebro.battery.enable = true;
            '';
          };

          timeout = lib.mkOption {
            type = lib.types.int;
            default = 1;
            description = ''
              Delay in seconds for the refresh of the module's data.
            '';
            example = ''
              cerebro.battery.timeout = 1;
            '';
          };

          json = {
            enable = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = ''
                Toggle used to enable/disable the Json export for the battery
                module.
              '';
              example = ''
                cerebro.battery.json.enable = true;
              '';
            };
          };

          shell = {
            enable = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = ''
                Toggle used to enable/disable the shell export for the battery
                module.
              '';
              example = ''
                cerebro.battery.shell.enable = true;
              '';
            };
          };
        };

        # Brightness module
        brightness = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = ''
              Toggle used to enable/disable the brightness module. This module
              provides information about the brightness of the displays.
            '';
            example = ''
              cerebro.brightness.enable = true;
            '';
          };

          timeout = lib.mkOption {
            type = lib.types.int;
            default = 0;
            description = ''
              Delay in seconds for the refresh of the module's data.
            '';
            example = ''
              cerebro.brightness.timeout = 1;
            '';
          };

          json = {
            enable = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = ''
                Toggle used to enable/disable the Json export for the brightness
                module.
              '';
              example = ''
                cerebro.brightness.json.enable = true;
              '';
            };
          };

          shell = {
            enable = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = ''
                Toggle used to enable/disable the shell export for the
                brightness module.
              '';
              example = ''
                cerebro.brightness.shell.enable = true;
              '';
            };
          };
        };

        # Memory module
        memory = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = ''
              Toggle used to enable/disable the memory module. This module
              provides information about the RAM usage.
            '';
            example = ''
              cerebro.memory.enable = true;
            '';
          };

          timeout = lib.mkOption {
            type = lib.types.int;
            default = 1;
            description = ''
              Delay in seconds for the refresh of the module's data.
            '';
            example = ''
              cerebro.memory.timeout = 1;
            '';
          };

          json = {
            enable = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = ''
                Toggle used to enable/disable the Json export for the memory
                module.
              '';
              example = ''
                cerebro.memory.json.enable = true;
              '';
            };
          };

          shell = {
            enable = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = ''
                Toggle used to enable/disable the shell export for the memory
                module.
              '';
              example = ''
                cerebro.memory.shell.enable = true;
              '';
            };
          };
        };

        # Trash module
        trash = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = ''
              Toggle used to enable/disable the trash module. This module
              provides information about the trash and its content.
            '';
            example = ''
              cerebro.trash.enable = true;
            '';
          };

          timeout = lib.mkOption {
            type = lib.types.int;
            default = 0;
            description = ''
              Delay in seconds for the refresh of the module's data.
            '';
            example = ''
              cerebro.trash.timeout = 1;
            '';
          };

          json = {
            enable = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = ''
                Toggle used to enable/disable the Json export for the trash
                module.
              '';
              example = ''
                cerebro.trash.json.enable = true;
              '';
            };
          };

          shell = {
            enable = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = ''
                Toggle used to enable/disable the shell export for the trash
                module.
              '';
              example = ''
                cerebro.trash.shell.enable = true;
              '';
            };
          };
        };
      };
    };
  };

  # Make per-user configuration
  makeUserConfiguration = { username, ... }:
    let
      cfg = config.hm."${username}".cerebro;

      hasLogFile = cfg.logFile != "";

      daemonOpts = "-m ${cfg.mountPoint}" +
        (lib.strings.optionalString hasLogFile " -l ${cfg.logFile}");

      temperatureSettings = config.settings.hardware.cpu.temperature;
    in
    {
      "name" = username;
      "value" = lib.mkIf cfg.enable {
        # Configuration file
        home.file."${configDir}/config.json" = {
          text = ''
          {
              "modules":
              {
                  "cpu":
                  {
                      "enabled": ${boolToString cfg.cpu.enable},
                      "timeout_s": ${toString cfg.cpu.timeout},

                      "temperature":
                      {
                          "device": "${temperatureSettings.device}",
                          "pattern": "${temperatureSettings.core_pattern}"
                      },

                      "json":
                      {
                          "enabled": ${boolToString cfg.cpu.json.enable}
                      },

                      "shell":
                      {
                          "enabled": ${boolToString cfg.cpu.shell.enable}
                      }
                  },

                  "battery":
                  {
                      "enabled": ${boolToString cfg.battery.enable},
                      "timeout_s": ${toString cfg.battery.timeout},

                      "json":
                      {
                          "enabled": ${boolToString cfg.battery.json.enable}
                      },

                      "shell":
                      {
                          "enabled": ${boolToString cfg.battery.shell.enable}
                      }
                  },

                  "brightness":
                  {
                      "enabled": ${boolToString cfg.brightness.enable},
                      "timeout_s": ${toString cfg.brightness.timeout},

                      "json":
                      {
                          "enabled": ${boolToString cfg.brightness.json.enable}
                      },

                      "shell":
                      {
                          "enabled": ${boolToString cfg.brightness.shell.enable}
                      }
                  },

                  "memory":
                  {
                      "enabled": ${boolToString cfg.memory.enable},
                      "timeout_s": ${toString cfg.memory.timeout},

                      "json":
                      {
                          "enabled": ${boolToString cfg.memory.json.enable}
                      },

                      "shell":
                      {
                          "enabled": ${boolToString cfg.memory.shell.enable}
                      }
                  },

                  "trash":
                  {
                      "enabled": ${boolToString cfg.trash.enable},
                      "timeout_s": ${toString cfg.trash.timeout},

                      "json":
                      {
                          "enabled": ${boolToString cfg.trash.json.enable}
                      },

                      "shell":
                      {
                          "enabled": ${boolToString cfg.trash.shell.enable}
                      }
                  }
              }
          }
          '';
        };

        # User systemd service
        systemd.user.services.cerebro = {
          Unit = {
            Description = "Cerebro service";
          };

          Install.WantedBy = [ "graphical-session.target" ];

          Service = {
            Type = "simple";

            Environment = "PATH=/run/current-system/sw/bin";

            ExecStartPre = "${mkdir} -p ${cfg.mountPoint}";
            ExecStart = "${cerebro}/bin/cerebro ${daemonOpts}";

            ExecStop = "${fusermount} -u ${cfg.mountPoint}";
          };
        };
      };
    };

  # Enable packages if at least one user had enabled this module
  enablePackages = { username, ... }:
    lib.mkIf config.hm."${username}".cerebro.enable {
      systemPackages = [
        pkgs.dpkg

        cerebro
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
