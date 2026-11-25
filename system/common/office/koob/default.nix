{ pkgs, ... }:

let
  koob = pkgs.callPackage ./derivation.nix { };
in
{
  environment.systemPackages = [ koob ];
}
