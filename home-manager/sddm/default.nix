{ config, lib, pkgs, ... }:

let
  # Make per-user options
  # TODO: add theme configuration
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      sddm = {
        enable = lib.mkEnableOption "sddm configuration";
      };
    };
  };

  # Make services configuration
  makeServicesConfiguration = { username, ... }:
    lib.mkIf config.hm."${username}".sddm.enable {
      xserver.displayManager.sddm = {
        enable = true;

        theme = "${(pkgs.fetchFromGitHub {
          owner = "MarianArlt";
          repo = "sddm-sugar-dark";
          rev = "9fc363cc3f6b3f70df948c88cbe26989386ee20d";
          sha256 = "1vb0gr9i4dj6bzrx73cacnn012crvpj4d1n3yiw5w2yhrbpjkql7";
          #sha256 = lib.fakeSha256;
        })}";
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
    services =
      lib.mkMerge (map makeServicesConfiguration config.settings.users);
  };
}
