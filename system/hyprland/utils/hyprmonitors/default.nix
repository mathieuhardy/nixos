{ pkgs, ... }:

let
  hyprmonitors = pkgs.callPackage ./derivation.nix { };
in
{
  environment.systemPackages = [ hyprmonitors ];
}
