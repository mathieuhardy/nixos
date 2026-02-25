{ ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Hyrpidle in user space to be able to access DBUS and other stuff
  # ────────────────────────────────────────────────────────────────────────────

  services.hypridle = {
    enable = true;
  };

  # ────────────────────────────────────────────────────────────────────────────
  # Link to config:
  #   ~/.config/hypr/hypridle.conf
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."hypr/hypridle.conf".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/hypridle/hypridle.conf";
}
