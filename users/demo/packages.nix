{ pkgs, ... }:

{
  # ----------------------------------------------------------------------------
  # System packages
  # ----------------------------------------------------------------------------

  environment.systemPackages = with pkgs; [
    gnome3.adwaita-icon-theme
    bat
    fd
    feh
    kcalc
    networkmanagerapplet
    ripgrep
    sysstat
    tree
  ];
}
