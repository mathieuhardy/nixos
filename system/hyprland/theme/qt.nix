{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Qt theming (use Kvantum)
    catppuccin-kvantum
    kdePackages.qtstyleplugin-kvantum

    # Qt6 specific
    qt6.qtwayland
    qt6Packages.qt6ct

    # Qt5 specific
    libsForQt5.qt5ct
  ];
}
