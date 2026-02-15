{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Link to config
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."lsd".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/lsd-config";
}
