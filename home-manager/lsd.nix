{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Link to config
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."lsd".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/lsd-config";

  xdg.configFile."lsd/colors".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/lsd-config/catppuccin-frappe.yaml";
}
