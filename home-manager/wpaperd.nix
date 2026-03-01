{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Link to config:
  #   ~/.config/wpaperd/
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."wpaperd".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/wpaperd";
}
