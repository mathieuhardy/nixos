{ pkgs, ... }:

let
  git-branch-checker = pkgs.callPackage ./derivation.nix { };
in
{
  environment.systemPackages = [ git-branch-checker ];
}
