{ ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Waybar in user space to be able to access DBUS and other stuff
  # ────────────────────────────────────────────────────────────────────────────

  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };

  # ────────────────────────────────────────────────────────────────────────────
  # Link to config:
  #   ~/.config/waybar/
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."waybar".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/waybar";
}
