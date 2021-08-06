{ config, lib, ... }:

{
  # ----------------------------------------------------------------------------
  # XServer
  # ----------------------------------------------------------------------------

  services.xserver = {
    enable = true;
    layout = "fr";

    displayManager = {
      # French keyboard
      sessionCommands = "setxkbmap fr";

      # Auto login
      autoLogin = lib.mkIf (config.settings.autoLoginUser != "") {
        enable = true;
        user = "${config.settings.autoLoginUser}";
      };
    };
  };

  # ----------------------------------------------------------------------------
  # Console
  # ----------------------------------------------------------------------------

  console.useXkbConfig = true;
}
