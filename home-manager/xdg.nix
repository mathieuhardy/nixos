{ pkgs, ... }:

let
  gparted-wayland = pkgs.writeShellScript "gparted-wayland" ''
    exec sudo XDG_RUNTIME_DIR=/run/user/$(id -u) WAYLAND_DISPLAY=$WAYLAND_DISPLAY GDK_BACKEND=wayland gparted
  '';
in
{
  # ────────────────────────────────────────────────────────────────────────────
  # XDG directories
  #   - create directories automatically
  # ────────────────────────────────────────────────────────────────────────────

  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;

  # ────────────────────────────────────────────────────────────────────────────
  # Desktop entries overrides
  # ────────────────────────────────────────────────────────────────────────────

  xdg.desktopEntries.gparted = {
    name = "GParted";
    icon = "gparted";
    terminal = false;
    type = "Application";
    categories = [
      "GNOME"
      "GTK"
      "System"
      "Filesystem"
    ];
    exec = "${gparted-wayland}";
  };
}
