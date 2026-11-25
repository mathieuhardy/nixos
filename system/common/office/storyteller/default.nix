{ pkgs, ... }:

let
  storyteller = pkgs.callPackage ./derivation.nix { };
in
{
  environment.systemPackages = [ storyteller ];
}
