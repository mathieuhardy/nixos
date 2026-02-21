{ ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Session variables
  # ────────────────────────────────────────────────────────────────────────────

  environment.sessionVariables = {
    # Use wayland and fallback to X11 for Qt applications
    QT_QPA_PLATFORM = "wayland;xcb";

    # Use qt6ct for theming
    QT_QPA_PLATFORMTHEME = "qt6ct";

    # Let wayland handle window decorations
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    # Use wayland and fallback to X11 for GTK applications
    GDK_BACKEND = "wayland,x11,*";

    # Use wayland and fallback to X11 for SQL applications
    SDL_VIDEODRIVER = "wayland,x11";

    # For Gnome applications (should be useless)
    CLUTTER_BACKEND = "wayland";

    # For Electron applications
    NIXOS_OZONE_WL = "1";

    # XDG_CURRENT_DESKTOP = "Hyprland";
    # XDG_SESSION_TYPE = "wayland";
    # XDG_SESSION_DESKTOP = "Hyprland";
  };
}
