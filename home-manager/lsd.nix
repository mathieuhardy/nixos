{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Link to config
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."lsd/config.yaml".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/lsd-config/config.yaml";

  xdg.configFile."lsd/colors.yaml".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/lsd-config/catppuccin-frappe.yaml";
}
