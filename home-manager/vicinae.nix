{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Enable package and service
  # ────────────────────────────────────────────────────────────────────────────

  programs.vicinae = {
    enable = true;

    systemd = {
      enable = true;
      autoStart = true;
    };
  };

  # ────────────────────────────────────────────────────────────────────────────
  # Link to config:
  #   ~/.config/vicinae/vicinae.json
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."vicinae/vicinae.json".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/vicinae/vicinae.json";
}
