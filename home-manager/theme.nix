{ pkgs, ... }:

let
  catppuccin-gtk = pkgs.catppuccin-gtk.override {
    accents = [ "mauve" ];
    variant = "frappe";
    tweaks = [ "normal" ];
  };
in
{
  # ────────────────────────────────────────────────────────────────────────────
  # GTK
  # ────────────────────────────────────────────────────────────────────────────

  gtk = {
    enable = true;

    theme = {
      name = "catppuccin-frappe-mauve-normal";
      package = catppuccin-gtk;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "catppuccin-frappe-mauve-cursors";
      package = pkgs.catppuccin-cursors.frappeMauve;
    };
  };

  # Lien symbolique du thème GTK4
  xdg.configFile."gtk-4.0/gtk.css" = {
    source = "${catppuccin-gtk}/share/themes/catppuccin-frappe-mauve-normal/gtk-4.0/gtk.css";
  };

  xdg.configFile."gtk-4.0/gtk-dark.css" = {
    source = "${catppuccin-gtk}/share/themes/catppuccin-frappe-mauve-normal/gtk-4.0/gtk-dark.css";
  };

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark"; # GTK4 + Electron
    gtk-theme = "catppuccin-frappe-mauve-normal"; # Some apps may use this
  };

  home.sessionVariables = {
    GTK_THEME = "catppuccin-frappe-mauve-normal";

    # Force dark mode in libadwaita/GTK4
    ADW_DISABLE_PORTAL = "1";
  };

  # Force dark mode for GTK4 using settings.ini
  xdg.configFile."gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme=true
  '';

  # ────────────────────────────────────────────────────────────────────────────
  # Qt
  # ────────────────────────────────────────────────────────────────────────────

  qt = {
    enable = true;
    platformTheme.name = "gtk"; # Follow Gtk theme
    style = {
      name = "kvantum";
      package = pkgs.catppuccin-kvantum;
    };
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Catppuccin-Frappe-Mauve
  '';
}
