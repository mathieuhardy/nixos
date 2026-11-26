{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Link to configs:
  #   ~/.config/ski/settings.json
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."ski/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/ski/settings.json";
}
