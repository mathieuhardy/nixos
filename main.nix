{ ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Experimental features
  # ────────────────────────────────────────────────────────────────────────────

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # ────────────────────────────────────────────────────────────────────────────
  # Imports
  # ────────────────────────────────────────────────────────────────────────────

  imports = [
    # Hardware
    ./hardware/bluetooth.nix
    ./hardware/laptop.nix
    ./hardware/lenovo/thinkpad/p14s-gen1-amd.nix

    # System configuration
    ./system
  ];
}
