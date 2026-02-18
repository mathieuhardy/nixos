{ config, pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # XDG desktop portal
  # ────────────────────────────────────────────────────────────────────────────

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];

    config.common.default = "*";
  };
}
