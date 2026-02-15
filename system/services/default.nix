{ ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Imports
  # ────────────────────────────────────────────────────────────────────────────

  imports = [
    # ./blueman.nix
    ./desktop-manager.nix
    ./display-manager.nix
    ./openssh.nix
    ./printing.nix
    ./xserver.nix
  ];
}
