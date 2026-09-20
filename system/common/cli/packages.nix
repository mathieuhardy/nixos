{ pkgs, ... }:

let
  loglit = pkgs.callPackage ../custom-packages/loglit.nix { };
in
{
  environment.systemPackages = with pkgs; [
    bottom
    fd
    loglit
    lsd
    ripgrep
    trashy
    unzip
    zip
  ];

  programs = {
    bat.enable = true;
  };
}
