{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Imports
  # ────────────────────────────────────────────────────────────────────────────

  imports = [
    ./alacritty.nix
    ./fish.nix
    ./git.nix
    ./input-remapper.nix
    ./lsd.nix
    ./mpv.nix
    ./neovim.nix
    ./secrets.nix
    ./ssh.nix
    ./xdg.nix
    ./zed.nix
  ];

  # ────────────────────────────────────────────────────────────────────────────
  # Global home-manager configuration
  # ────────────────────────────────────────────────────────────────────────────

  home.username = "${osConfig.settings.userLogin}";
  home.homeDirectory = "/home/${osConfig.settings.userLogin}";

  home.stateVersion = lib.trivial.release;

  # TODO: pour hyprland
  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "Adwaita-dark";
  #     package = pkgs.gnome-themes-extra;
  #   };
  #   gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  #   gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  # };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk"; # suit le thème GTK
    # ou "qtct" si tu veux qt5ct/qt6ct
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };

  wayland.windowManager.hyprland.settings.env = [
    "QT_QPA_PLATFORMTHEME,qt5ct"
    "GTK_THEME,Adwaita:dark"
  ];
}
