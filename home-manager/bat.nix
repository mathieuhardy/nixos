{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Link to config:
  #   ~/.config/bat/
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."bat".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/bat";
}
