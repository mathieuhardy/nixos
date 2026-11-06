{ pkgs, pkgs-unstable, ... }:

let
  network-manager-sidebar = pkgs.callPackage ./derivation.nix {
    gtk4-layer-shell = pkgs-unstable.gtk4-layer-shell;
  };
in
{

  # ────────────────────────────────────────────────────────────────────────────
  # Package
  # ────────────────────────────────────────────────────────────────────────────

  environment.systemPackages = [ network-manager-sidebar ];
}
