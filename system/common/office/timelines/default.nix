{ pkgs, ... }:

let
  timelines = pkgs.callPackage ./derivation.nix { };
in
{
  environment.systemPackages = [ timelines ];
}
