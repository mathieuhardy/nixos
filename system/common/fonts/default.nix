{ pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Fonts
  # ────────────────────────────────────────────────────────────────────────────

  fonts = {
    packages = with pkgs; [
      inter # For GUI
      nerd-fonts.commit-mono # For development
      noto-fonts # For the rest
      noto-fonts-color-emoji
    ];

    fontconfig = {
      enable = true;

      defaultFonts = {
        monospace = [
          "CommitMono Nerd Font"
        ];

        sansSerif = [
          "Noto Sans"
          "Inter"
        ];

        serif = [
          "Noto Serif"
        ];

        emoji = [
          "Noto Color Emoji"
        ];
      };
    };
  };

  # TODO: remove
  # environment.systemPackages = with pkgs; [
  #   adwaita-icon-theme # icônes symboliques GTK4 / libadwaita
  #   gnome-themes-extra # plus de thèmes et icônes optionnels
  # ];
  #
  # environment.variables = {
  #   GDK_BACKEND = "wayland"; # obligatoire pour Hyprland
  #   GTK_USE_PORTAL = "1"; # pour GTK apps sandboxées
  #   FONTCONFIG_PATH = "${pkgs.fontconfig}/etc/fonts"; # pour Pango / fontconfig
  # };
}
