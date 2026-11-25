{ pkgs, ... }:

let
  gitwatch = pkgs.callPackage ./derivation.nix { };
in
{
  environment.systemPackages = [ gitwatch ];
}
