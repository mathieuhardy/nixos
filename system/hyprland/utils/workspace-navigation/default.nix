{ pkgs, ... }:

let
  workspace-navigation = pkgs.callPackage ./derivation.nix { };
in
{
  # ────────────────────────────────────────────────────────────────────────────
  # Package
  # ────────────────────────────────────────────────────────────────────────────

  environment.systemPackages = [ workspace-navigation ];
}
