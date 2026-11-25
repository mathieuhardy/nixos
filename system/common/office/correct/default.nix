{ pkgs, ... }:

let
  correct = pkgs.callPackage ./derivation.nix { };
in
{
  environment.systemPackages = [ correct ];
}
