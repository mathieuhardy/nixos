{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Link to configs:
  #   ~/.config/lsd/config.yaml
  #   ~/.config/lsd/colors.yaml
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."lsd/config.yaml".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/lsd/config.yaml";

  xdg.configFile."lsd/colors.yaml".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/lsd/catppuccin-frappe.yaml";
}
