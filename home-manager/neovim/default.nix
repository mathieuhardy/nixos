{ config, lib, pkgs, ... }:

let
  unstable = import <nixos-unstable> {};

  # Variables
  configDir = ".config/nvim";

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      neovim = {
        enable = lib.mkEnableOption "neovim configuration";
      };
    };
  };

  # Make per-user configuration
  makeUserConfiguration = { username, ... }: {
    "name" = username;
    "value" = lib.mkIf config.hm."${username}".neovim.enable {
      home.file."${configDir}/init.vim".source = ./resources/init.vim;
      home.file."${configDir}/book.vim".source = ./resources/book.vim;
      home.file."${configDir}/colors".source = ./resources/colors;
      home.file."${configDir}/local-plugged".source = ./resources/plugins;
    };
  };

  # Enable packages if at least one user had enabled this module
  enablePackages = { username, ... }:
    lib.mkIf config.hm."${username}".neovim.enable {
      systemPackages = [
        pkgs.cscope
        pkgs.nodejs
        pkgs.yarn

        unstable.neovim
      ];
    };

  # Enable aliases if at least one user had enabled it
  enableAliases = { username, ... }:
    lib.mkIf config.hm."${username}".neovim.enable
      (self: super: {
        neovim = super.neovim.override {
          viAlias = true;
          vimAlias = true;
          withPython3 = true;

          extraPython3Packages = (ps: with ps; [
            jedi
          ]);
        };
      });
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

    nixpkgs.overlays = map enableAliases config.settings.users;

    home-manager.users =
      builtins.listToAttrs (map makeUserConfiguration config.settings.users);
  };
}
