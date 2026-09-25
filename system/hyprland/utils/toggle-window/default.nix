{ pkgs, ... }:

let
  toggle-window = pkgs.callPackage ./derivation.nix { };
in
{
  # ────────────────────────────────────────────────────────────────────────────
  # Package
  # ────────────────────────────────────────────────────────────────────────────

  environment.systemPackages = [ toggle-window ];
}
