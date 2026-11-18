{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    # Application compatibility
    dpkg
    nix-ld

    # Various
    input-remapper
    gnome-calculator

    # Whatsapp
    # pkgs-unstable.zapfast
  ];

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
