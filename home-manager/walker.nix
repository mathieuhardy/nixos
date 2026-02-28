{ config, osConfig, ... }:

let
  uid = builtins.getEnv "UID";
in
{
  # ────────────────────────────────────────────────────────────────────────────
  # Enable package and service
  # ────────────────────────────────────────────────────────────────────────────

  services.walker = {
    enable = true;
    systemd.enable = true;

  };

  # ────────────────────────────────────────────────────────────────────────────
  # Link to config:
  #   ~/.config/walker/
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."walker".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/walker";
}
