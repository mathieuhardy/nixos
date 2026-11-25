{ pkgs, ... }:

let
  trash-monitor = pkgs.callPackage ./derivation.nix { };
in
{
  environment.systemPackages = [ trash-monitor ];
}
