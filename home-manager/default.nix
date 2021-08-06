{ ... }:

let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "63f299b3347aea183fc5088e4d6c4a193b334a41";
    ref = "release-20.09";
  };
in
{
  # ----------------------------------------------------------------------------
  # Imports
  # ----------------------------------------------------------------------------

  imports = [
    (import "${home-manager}/nixos")

    ./add
    ./alacritty
    ./bspwm
    ./cerebro
    ./dunst
    ./easier
    ./feh
    ./fish
    ./git
    ./gsimplecal
    ./gtk
    ./inputs/trackballs/elecom-deft-pro
    ./inputs/trackballs/mte
    ./iwd
    ./lightdm
    ./lok
    ./nautilus
    ./neovim
    ./nixpkgs
    ./override
    ./polybar
    ./rice
    ./rofi
    ./sddm
    ./sxhkd
    ./thunar
    ./vlc
    ./xserver
  ];

  # ----------------------------------------------------------------------------
  # Configuration
  # ----------------------------------------------------------------------------

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };
}
