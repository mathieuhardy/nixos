{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Link to config:
  #   ~/.config/alacritty/
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."alacritty".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/alacritty-config";
}
