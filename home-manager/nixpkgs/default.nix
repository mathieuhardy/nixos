{ config, lib, ... }:

let
  #Helpers
  boolToString = value : if value then "true" else "false";

  # Variables
  configDir = ".config/nixpkgs";

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      nixpkgs = {
        enable = lib.mkEnableOption "nixpkgs configuration";

        allowUnfree = lib.mkEnableOption "unfree packages";
      };
    };
  };

  # Make per-user configuration
  makeUserConfiguration = { username, ... }:
    let
      cfg = config.hm."${username}".nixpkgs;
    in
    {
      "name" = username;
      "value" = lib.mkIf config.hm."${username}".nixpkgs.enable {
        home.file."${configDir}/config.nix".text = ''
          {
            allowUnfree = ${boolToString cfg.allowUnfree};
          }
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
