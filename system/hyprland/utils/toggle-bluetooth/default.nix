{ pkgs, ... }:

let
  toggle-bluetooth = pkgs.callPackage ./derivation.nix { };
in
{
  # ────────────────────────────────────────────────────────────────────────────
  # Package
  # ────────────────────────────────────────────────────────────────────────────

  environment.systemPackages = [ toggle-bluetooth ];
}
