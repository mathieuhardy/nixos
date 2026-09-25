{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Application compatibility
    appimage-run
    dpkg
    nix-ld

    # Various
    input-remapper
    speedcrunch # Calculator
  ];
}
