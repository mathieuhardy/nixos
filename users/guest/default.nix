{ pkgs, ... }:

let
  # Find a locker
  user = {
    username = "guest";
    name = "Guest user account";
    email = "guest@guest.com";
    groups = [ "networkmanager" "wheel" ];
    uid = 1001;
    shell = pkgs.fish;
    password = "$6$HTUfTy.x//4J$0Bl4/QKigeVMqFIYonVGmPrrjv3zzC8c7d.PdgsZURRE0o389.oLcY0Zox.4mvZvAxVzlXPgOsbkhcbBqY3Nx1"; # guest

    gitEditor = "nvim";
  };
in
{
  # ----------------------------------------------------------------------------
  # Imports
  # ----------------------------------------------------------------------------

  imports = [
    # User specific
    ./fonts.nix
    ./packages.nix
  ];

  # ----------------------------------------------------------------------------
  # Configuration
  # ----------------------------------------------------------------------------

  hm."${user.username}" = {
    alacritty.enable = true;

    bspwm.enable = true;

    dunst.enable = true;

    elecomDeftPro = {
      enable = true;

      middle = 0;
      fn1 = 2;
      fn2 = 1;
    };

    fish.enable = true;

    git.enable = true;

    gsimplecal.enable = true;

    iwd.enable = true;

    microsoftTrackballExplorer ={
      enable = true;

      right = 0;
      fn1 = 3;
    };

    nautilus.enable = true;

    neovim.enable = true;

    nixpkgs.enable = true;

    polybar.enable = true;

    rofi.enable = true;

    sddm.enable = true;

    sxhkd.enable = true;

    vlc.enable = true;

    xserver = {
      enable = true;

      applicationsMenu = "rofi -show drun";
      editor = "nvim";
      fileManager = "nautilus";
      locker = "lok icecold2.png";
      powerMenu = "rofi-power-menu";
      runInTerminal = "alacritty -e";
      terminal = "alacritty";
      volumeControl = "pavucontrol";
      wallpaper = "trees.jpg";
      webBrowser = "firefox";

      windowManager = {
        name = "bspwm";
        reload = "bspc wm -r";
        kill = "bspc quit";
      };
    };
  };

  # ----------------------------------------------------------------------------
  # Settings
  # ----------------------------------------------------------------------------

  settings.users = [ user ];
}
