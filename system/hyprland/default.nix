{ ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Imports
  # ────────────────────────────────────────────────────────────────────────────

  imports = [
    # ./display-manager
    # ./env
    ./window-manager
    # ./xdg

    # ./packages.nix
  ];

  # TODO: to be sorted
  security.pam.services.hyprlock = { };
}
