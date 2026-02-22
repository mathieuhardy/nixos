{ pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # GTK
  # ────────────────────────────────────────────────────────────────────────────

  gtk = {
    enable = true;

    theme = {
      name = "catppuccin-mocha-sapphire-standard";
      package = pkgs.catppuccin-gtk;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "catppuccin-frappe-sapphire-cursors";
      package = pkgs.catppuccin-cursors.frappeSapphire;
    };
  };

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark"; # GTK4 + Electron
    gtk-theme = "catppuccin-mocha-sapphire-standard"; # Some apps may use this
  };

  home.sessionVariables = {
    GTK_THEME = "catppuccin-mocha-sapphire-standard";
  };

  # ────────────────────────────────────────────────────────────────────────────
  # Qt
  # ────────────────────────────────────────────────────────────────────────────

  qt = {
    enable = true;
    platformTheme.name = "gtk"; # Follow Gtk theme
    style.name = "kvantum";
  };
}
