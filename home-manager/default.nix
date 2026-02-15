{ pkgs, ... }:

# TODO: clean
{
  # ────────────────────────────────────────────────────────────────────────────
  # Imports
  # ────────────────────────────────────────────────────────────────────────────

  imports = [
    ./fish.nix
    ./git.nix
    ./input-remapper.nix
    ./lsd.nix
    ./mpv.nix
    ./neovim.nix
    ./zed.nix
  ];

  home.username = "mhardy";
  home.homeDirectory = "/home/mhardy";

  home.packages = [
    # pkgs.nerd-fonts.commit-mono

    # pkgs.arc-kde-theme      # le thème Arc pour KDE/Kvantum
    # pkgs.papirus-icon-theme # icons recommandés avec Arc
  ];

  # Configure Qt pour utiliser Kvantum
  # qt = {
  #   enable = true;
  #   platformTheme.name = "breeze";
  #   style.name = "breeze";
  # };

  # programs.plasma = {
  #   enable = true;
  #
  #   workspace = {
  #     lookAndFeel = "com.github.varlesh.arc-darker";  # Global Theme => ArcDarker
  #     colorScheme = "ArcDark";                         # Colors => Arc Dark
  #     theme = "arc-dark";                              # Plasma Style => Arc Dark
  #     iconTheme = "Papirus";                           # Icons => Papirus
  #     cursor.theme = "breeze_cursors";                 # Cursors => Breeze
  #   };
  #
  #   window-decorations = {
  #     theme = "Arc Dark";                              # Window Decorations => Arc Dark
  #     library = "org.kde.kdecoration2";
  #   };
  # };

  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;

  home.stateVersion = "25.11";
}
