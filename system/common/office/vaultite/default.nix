{ pkgs, ... }:

let
  vaultite = pkgs.callPackage ./derivation.nix { };
in
{
  environment.systemPackages = [ vaultite ];
}
