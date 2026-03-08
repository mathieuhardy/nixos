{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Link to config:
  #   ~/.wezterm.lua
  # ────────────────────────────────────────────────────────────────────────────

  home.file.".wezterm.lua".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/wezterm/wezterm.lua";
}
