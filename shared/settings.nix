{ config, lib, ... }:

with lib;

{
  options = {
    settings = {
      # NixOS version
      version = mkOption {
        type = with types; uniq str;
        default = "20.09";
        description = ''
          The value to be set in the stateVersion.
        '';
        example = ''
          config.settings.version = "21.05";
        '';
      };

      # List of users configurations
      users = mkOption {
        type = with types; listOf attrs;
        default = [];
        description = ''
          The list of users with their configuration.
        '';
        example = ''
          config.settings.users = [
            {
              username = "jdoe";
              ...
            }
          ];
        '';
      };

      # Name of the user to auto log in
      autoLoginUser = mkOption {
        type = with types; str;
        default = "";
        description = ''
          Username to be used for auto-login. If none is provided then
          auto-login is disabled.
        '';
        example = ''
          config.settings.autoLoginUser = "jdoe";
        '';
      };

      # Hardware configuration
      hardware = {
        cpu = {
          temperature = {
            device = mkOption {
              type = with types; str;
              default = "";
              description = ''
                Device name to be used when try to find CPU temperature.
              '';
              example = ''
                config.settings.hardware.cpu.temperature.device = "intel";
              '';
            };

            core_pattern = mkOption {
              type = with types; str;
              default = "";
              description = ''
                Patter used to find the files providing the CPU cores
                temperature inside the device's directory.
              '';
              example = ''
                config.settings.hardware.cpu.temperature.core_pattern =
                  "^Core [0-9]+$";
              '';
            };
          };
        };
      };
    };
  };
}
