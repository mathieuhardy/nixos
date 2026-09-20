{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    imagemagick
    mpv
    shotcut # Video editor
    vlc
  ];
}
