{ pkgs, ... }:

let
  diskard = pkgs.callPackage ./derivation.nix { };
in
{

  # ────────────────────────────────────────────────────────────────────────────
  # Package
  # ────────────────────────────────────────────────────────────────────────────

  environment.systemPackages = [ diskard ];
}
