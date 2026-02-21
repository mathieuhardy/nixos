{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Link to config
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."alacritty".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/alacritty-config";
}
