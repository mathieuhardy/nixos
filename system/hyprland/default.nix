{ pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Imports
  # ────────────────────────────────────────────────────────────────────────────

  imports = [
    ./battery
    # ./display-manager
    # ./env
    ./window-manager
    # ./xdg

    ./packages.nix
  ];

  # TODO: to be sorted
  security.pam.services.hyprlock = { };

  # services.xdg-desktop-portal = {
  #   enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  # };
}
