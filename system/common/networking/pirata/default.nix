{ pkgs, ... }:

let
  pirata = pkgs.callPackage ./derivation.nix { };
in
{
  environment.systemPackages = [ pirata ];
}
