{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Link to config:
  #   ~/.config/pirate-ctl/config.toml
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."pirate-ctl/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/pirate-ctl/config.toml";
}
