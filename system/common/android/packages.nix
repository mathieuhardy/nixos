{ pkgs, ... }:

let
  altersend = pkgs.callPackage ../custom-packages/altersend.nix { };
in
{
  environment.systemPackages = with pkgs; [
    altersend # Send files from/to Android
    libmtp
    gvfs
  ];
}
