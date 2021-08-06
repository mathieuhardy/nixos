{ config, lib, pkgs, ... }:

let
  # Settings to apply
  settings = {
    "org/gnome/nautilus/list-view" = {
      default-visible-columns = ["name" "size" "date_modified"];
      use-tree-view = true;
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
    };
  };

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      nautilus = {
        enable = lib.mkEnableOption "nautilus configuration";
      };
    };
  };

  # Make per-user configuration
  makeUserConfiguration = { username, ... }: {
    "name" = username;
    "value" = lib.mkIf config.hm."${username}".nautilus.enable {
      dconf.settings = settings;
    };
  };

  # Enable packages if at least one user had enabled this module
  enablePackages = { username, ... }:
    lib.mkIf config.hm."${username}".nautilus.enable {
      dconf.enable = true;
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
    programs = lib.mkMerge (map enablePackages config.settings.users);

    home-manager.users =
      builtins.listToAttrs (map makeUserConfiguration config.settings.users);
  };
}
