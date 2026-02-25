{ pkgs, ... }:

let
  # TODO: remove
  catppuccin-gtk = pkgs.catppuccin-gtk.override {
    accents = [ "mauve" ];
    variant = "frappe";
    # tweaks = [ "normal" ];
  };
in
{
  # ────────────────────────────────────────────────────────────────────────────
  # GTK
  # ────────────────────────────────────────────────────────────────────────────

  gtk = {
    enable = true;

    theme = {
      name = "catppuccin-frappe-mauve-standard";
      package = catppuccin-gtk;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "catppuccin-frappe-mauve";
      package = pkgs.catppuccin-cursors.frappeMauve;
    };

    font = {
      name = "Inter";
      size = 10;
    };
  };

  # Lien symbolique du thème GTK4
  # TODO: remove
  # xdg.configFile."gtk-4.0/gtk.css" = {
  #   source = "${catppuccin-gtk}/share/themes/catppuccin-frappe-mauve-normal/gtk-4.0/gtk.css";
  # };

  # TODO: remove
  # xdg.configFile."gtk-4.0/gtk-dark.css" = {
  #   source = "${catppuccin-gtk}/share/themes/catppuccin-frappe-mauve-normal/gtk-4.0/gtk-dark.css";
  # };

  # TODO: remove
  # dconf.settings."org/gnome/desktop/interface" = {
  #   color-scheme = "prefer-dark"; # GTK4 + Electron
  #   gtk-theme = "catppuccin-frappe-mauve-normal"; # Some apps may use this
  # };

  # TODO: remove
  # home.sessionVariables = {
  #   GTK_THEME = "catppuccin-frappe-mauve-normal";
  #
  #   # Force dark mode in libadwaita/GTK4
  #   ADW_DISABLE_PORTAL = "1";
  # };

  # Force dark mode for GTK4 using settings.ini
  # TODO: remove if all GTK apps are well configured
  xdg.configFile."gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme=true
  '';

  # ────────────────────────────────────────────────────────────────────────────
  # Qt
  # ────────────────────────────────────────────────────────────────────────────

  qt = {
    enable = true;

    # TODO: remove ?
    # platformTheme.name = "gtk"; # Follow Gtk theme
    platformTheme.name = "qtct";

    style = {
      name = "kvantum";
      # TODO: remove ?
      # package = pkgs.catppuccin-kvantum;
    };
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Catppuccin-Frappe
  '';
}
