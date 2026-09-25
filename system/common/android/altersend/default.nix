{ pkgs, ... }:

let
  altersend = pkgs.callPackage ./derivation.nix { };
in
{
  environment.systemPackages = [ altersend ];
}
