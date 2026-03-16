{ pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Cursors
  # ────────────────────────────────────────────────────────────────────────────

  home.pointerCursor = {
    name = "Numix-Cursor-Light";
    package = pkgs.numix-cursor-theme;
    size = 24;
    x11.enable = true;
    gtk.enable = true;
  };

  wayland.windowManager.hyprland.settings = {
    env = [
      "XCURSOR_THEME,Numix-Cursor-Light"
      "XCURSOR_SIZE,24"
    ];
    exec-once = [
      "hyprctl setcursor Numix-Cursor-Light 24"
    ];
  };

  # ────────────────────────────────────────────────────────────────────────────
  # GTK
  # ────────────────────────────────────────────────────────────────────────────

  gtk = {
    enable = true;

    theme = {
      name = "catppuccin-frappe-mauve-standard";
    };

    iconTheme = {
      name = "Papirus-Dark";
    };

    cursorTheme = {
      name = "Numix-Cursor-Light";
    };

    font = {
      name = "Inter";
      size = 10;
    };
  };

  # Force dark mode for GTK3/GTK4 using settings.ini
  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme=true
  '';

  xdg.configFile."gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme=true
  '';

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark"; # GTK4 + Electron
  };

  # home.sessionVariables = {
  #   GTK_THEME = "catppuccin-frappe-mauve-standard";
  # };

  # ────────────────────────────────────────────────────────────────────────────
  # Qt
  # ────────────────────────────────────────────────────────────────────────────

  qt = {
    enable = true;

    platformTheme.name = "qtct";

    style = {
      name = "kvantum";
    };
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Catppuccin-Frappe
  '';
}
