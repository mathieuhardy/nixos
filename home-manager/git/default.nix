{ config, lib, pkgs, ... }:

let
  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      git = {
        enable = lib.mkEnableOption "git configuration";
      };
    };
  };

  # Make per-user configuration
  makeUserConfiguration = { username, name, email, ... }: {
    "name" = username;
    "value" = lib.mkIf config.hm."${username}".git.enable {
      programs.git = {
        enable = true;

        lfs.enable = true;

        userName = "${name}";
        userEmail = "${email}";

        extraConfig = {
          core = {
            editor = "vim";
          };
        };
      };
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
