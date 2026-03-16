_:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Session variables
  # ────────────────────────────────────────────────────────────────────────────

  environment.sessionVariables = {
    # Use wayland and fallback to X11 for Qt applications
    QT_QPA_PLATFORM = "wayland;xcb";

    # Use wayland and fallback to X11 for SQL applications
    SDL_VIDEODRIVER = "wayland,x11";

    # For Electron applications
    NIXOS_OZONE_WL = "1";
  };
}
