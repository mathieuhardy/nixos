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

  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;

  home.stateVersion = "25.11";

  # ── Thème GTK (applications Firefox, Nautilus, etc.) ──────────────────
  # gtk = {
  #   enable = true;
  #
  #   theme = {
  #     name = "Arc-Dark"; # ou "Arc", "Arc-Darker"
  #     package = pkgs.arc-theme;
  #   };
  #
  #   iconTheme = {
  #     name = "Papirus-Dark";
  #     package = pkgs.papirus-icon-theme;
  #   };
  #
  #   cursorTheme = {
  #     name = "Adwaita";
  #     size = 24;
  #   };
  #
  #   gtk3.extraConfig = {
  #     gtk-application-prefer-dark-theme = true;
  #   };
  #
  #   gtk4.extraConfig = {
  #     gtk-application-prefer-dark-theme = true;
  #   };
  # };

  # ── Thème Qt/KDE via Kvantum ───────────────────────────────────────────
  #   qt = {
  #     enable = true;
  #     platformTheme.name = "kvantum"; # Home Manager >= 23.11
  #     # Pour les versions plus anciennes : platformTheme = "kvantum";
  #     style.name = "kvantum";
  #   };
  #
  #   # Lier le thème Arc-Dark dans la config Kvantum
  #   xdg.configFile = {
  #     "Kvantum/ArcDark".source = "${pkgs.arc-kde-theme}/share/Kvantum/ArcDark";
  #
  #     "Kvantum/kvantum.kvconfig".text = ''
  #       [General]
  #       theme=ArcDark
  #     '';
  #   };
}
