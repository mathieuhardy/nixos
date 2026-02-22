{ ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Hyprland
  # ────────────────────────────────────────────────────────────────────────────

  programs.hyprland = {
    enable = true;

    # Use "Universal Wayland Session Manager"
    withUWSM = true;

    # XServer for compatibility
    xwayland.enable = true;
  };
}
