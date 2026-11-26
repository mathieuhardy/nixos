{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Link to config:
  #   ~/.config/pirata/config.toml
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."pirata/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/pirata/config.toml";

  # ────────────────────────────────────────────────────────────────────────────
  # XDG desktop entry
  # ────────────────────────────────────────────────────────────────────────────

  xdg.desktopEntries."pirata" = {
    name = "Pirata BitTorrent";
    comment = "BitTorrent search and download";
    exec = "alacritty --class pirata -e pirata tui";
    icon = "utilities-terminal";
    terminal = false;
    categories = [ "Utility" ];
  };
}
