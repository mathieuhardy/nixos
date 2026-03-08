{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Link to config:
  #   ~/.config/starship.toml
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."starship.toml".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/starship/starship.toml";
}
