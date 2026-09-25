{ pkgs, ... }:

let
  loglit = pkgs.callPackage ./derivation.nix { };
in
{
  environment.systemPackages = [ loglit ];
}
