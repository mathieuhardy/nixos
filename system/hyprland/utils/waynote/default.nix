{ pkgs, ... }:

let
  waynote = pkgs.callPackage ./derivation.nix { };
in
{
  environment.systemPackages = [ waynote ];
}
