{ pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Packages
  # ────────────────────────────────────────────────────────────────────────────

  # TODO: remove packages declared in the same file ?
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal
    xdg-desktop-portal-gtk # Fallback version
    xdg-desktop-portal-hyprland # Screen sharing, file pickers, etc
    xdg-utils
  ];

  # ────────────────────────────────────────────────────────────────────────────
  # XDG desktop portal
  # ────────────────────────────────────────────────────────────────────────────

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];

    config = {
      hyprland.default = [
        "hyprland"
        "gtk"
        "gnome"
      ];

      common.default = [
        "gtk"
        "gnome"
      ];
    };
  };

  # ────────────────────────────────────────────────────────────────────────────
  # XDG default applications
  # ────────────────────────────────────────────────────────────────────────────

  xdg.mime.defaultApplications = {
    "image/jpeg" = "swayimg.desktop";
    "image/png" = "swayimg.desktop";
    "image/gif" = "swayimg.desktop";
    "image/webp" = "swayimg.desktop";
  };
}
