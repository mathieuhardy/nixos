{ pkgs, ... }:

let
  pirate-ctl = pkgs.callPackage ./derivation.nix { };
in
{
  environment.systemPackages = [ pirate-ctl ];
}
