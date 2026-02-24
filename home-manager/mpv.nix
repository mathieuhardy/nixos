{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Link to config:
  #   ~/.config/mpv/
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."mpv".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/mpv-config";
}
