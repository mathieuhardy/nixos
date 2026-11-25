{ pkgs, ... }:

let
  rust-glancer = pkgs.callPackage ./derivation.nix { };
in
{
  environment.systemPackages = [ rust-glancer ];
}
