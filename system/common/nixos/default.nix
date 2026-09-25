{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    deadnix # Check for dead code in NixOS configuration
    nix-init # Generate Nix derivations
    statix # Analyze NixOS configuration
  ];
}
