{ pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Specific packages for Hyprland
  # ────────────────────────────────────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    # Hyprland ecosystem
    hyprpolkitagent
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-utils
    wayland-utils

    # Barre de statut
    waybar

    # App menu & settings (style KDE)
    nwg-menu # menu applications type KDE
    nwg-drawer # app drawer en grille
    nwg-look # GTK theme settings (équiv. System Settings KDE)

    # Gestion écrans multi-output
    nwg-displays # GUI pour layout multi-écrans sous Wayland
    wdisplays # alternative légère (fallback)

    # Qt6 Wayland
    qt6.qtwayland
    qt6Packages.qt6ct
    libsForQt5.qt5ct
    kdePackages.breeze
    kdePackages.breeze-icons

    # Notifications
    swaynotificationcenter
    libnotify

    # Audio
    pavucontrol
    pwvucontrol

    # Media player control (MPRIS)
    playerctl # play/pause/next/prev pour waybar mpris

    # Bluetooth
    blueman

    # Réseau
    networkmanagerapplet # nm-applet (tray) + nm-connection-editor
    networkmanager

    # Lock screen & idle
    hyprlock
    hypridle

    # Thème GTK + curseur
    catppuccin-gtk # thème GTK Mocha Mauve
    catppuccin-cursors # curseur Catppuccin Mocha Dark
    libsForQt5.qtstyleplugins
    kdePackages.breeze # thème Qt fallback

    # Kanshi — profils multi-écrans auto
    kanshi

    # Wallpaper
    swaybg

    # Luminosité (laptop)
    brightnessctl

    # Launcher
    wofi

    # Color picker
    hyprpicker # hyprpicker --autocopy --format hex

    # Emoji picker
    smile # GTK4, recherche, récents

    # Clipboard
    wl-clipboard
    cliphist # historique clipboard (texte + images)
    wtype # typing dans le champ actif (utilisé par smile)

    # Terminal
    kitty
  ];
}
