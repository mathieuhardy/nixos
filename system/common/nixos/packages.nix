{ pkgs, ... }:

let
  override = pkgs.callPackage ../custom-packages/override.nix { };
in
{
  environment.systemPackages = with pkgs; [
    deadnix # Check for dead code in NixOS configuration
    nix-init # Generate Nix derivations
    override # Script used to override symlinks created by NixOS
    statix # Analyze NixOS configuration
  ];
}
