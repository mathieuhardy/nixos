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

  environment.systemPackages = with pkgs; [
    # ddcutil # For brightnessctl to work on external screen
  ];

  # services.xdg-desktop-portal = {
  #   enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  # };

  # Pour accéder à l'écran sans root (brightnessctl)
  # hardware.i2c.enable = true;
  # users.users.mhardy.extraGroups = [ "i2c" ];
  # ddcutil setvcp 10 70  # luminosité à 70%
  # ddcutil getvcp 10     # valeur actuelle
  # bind = , XF86MonBrightnessUp, exec, ddcutil setvcp 10 + 10
  # bind = , XF86MonBrightnessDown, exec, ddcutil setvcp 10 - 10
}
