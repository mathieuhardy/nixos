{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Link to config:
  #   ~/.config/hypr/hyprlock.conf
  #   ~/.config/hypr/hyprlock-wallpaper.jpg
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."hypr/hyprlock.conf".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/hyprlock/hyprlock.conf";

  xdg.configFile."hypr/hyprlock-wallpaper.jpg".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/hyprlock/wallpaper.jpg";
}
