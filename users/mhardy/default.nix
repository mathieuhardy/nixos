{ config, options, pkgs, ... }:

let
  # Dependencies
  lok = pkgs.callPackage ../../packages/lok/lok.nix {};
  rofi-utils = pkgs.callPackage ../../packages/rofi-utils/rofi-utils.nix {};
  wallpapers = pkgs.callPackage ../../packages/wallpapers/wallpapers.nix {};

  # Find a locker
  user = {
    username = "mhardy";
    name = "Mathieu Hardy";
    email = "mhardy2008@gmail.com";
    groups = [ "audio" "networkmanager" "video" "wheel" ];
    uid = 1000;
    shell = pkgs.fish;
    password = "$6$hU7g.U7B4HuZh$yY8hTR47c.dkilUY0K7UtRXgUk/92LcfwwGPfZTKtV/zNpIO72R.VgZzYHiNSt5BN3IijHAP2zg63koYdgCXy.";

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
    add.enable = true;

    alacritty.enable = true;

    bspwm.enable = true;

    cerebro = {
      enable = true;

      cpu = {
        enable = true;
        timeout = 3;

        json.enable = true;
        shell.enable = true;
      };

      battery = {
        enable = true;
        timeout = 1;

        json.enable = true;
        shell.enable = true;
      };

      brightness = {
        enable = true;
        timeout = 0;

        json.enable = true;
        shell.enable = true;
      };

      memory = {
        enable = true;
        timeout = 3;

        json.enable = true;
        shell.enable = true;
      };

      trash = {
        enable = true;
        timeout = 0;

        json.enable = false;
        shell.enable = false;
      };
    };

    dunst.enable = true;

    easier.enable = true;

    elecomDeftPro =
    {
      enable = true;

      middle = 0;
      fn1 = options.hm."${user.username}".elecomDeftPro.middle.default;
      fn2 = options.hm."${user.username}".elecomDeftPro.left.default;
    };

    feh.enable = true;

    fish.enable = true;

    git.enable = true;

    gsimplecal = {
      enable = true;

      closeOnUnfocus = true;
      mainWindowKeepAbove = true;
      mainWindowSkipTaskbar = true;
      markToday = true;
      showCalendar = true;
      showWeekNumbers = true;
    };

    # This only enable packages dependencies but the gtk configuration must be
    # set using home-manager's configuration.
    gtk.enable = true;

    iwd.enable = true;

    lok.enable = true;

    mte =
    {
      enable = true;

      right = options.hm."${user.username}".mte.fn1.default;
      fn1 = options.hm."${user.username}".mte.right.default;
    };

    neovim.enable = true;

    nixpkgs.enable = true;

    override.enable = true;

    polybar.enable = true;

    rofi.enable = true;

    sddm.enable = true;

    sxhkd.enable = true;

    thunar = {
      enable = true;

      plugins.archive = true;
    };

    vlc.enable = true;

    xserver = {
      enable = true;

      applicationsMenu = "${pkgs.rofi}/bin/rofi -show drun";
      webBrowser = "${pkgs.firefox}/bin/firefox";
      editor = "${pkgs.neovim}/bin/nvim";
      fileManager = "${pkgs.xfce.thunar}/bin/thunar";
      locker = "${lok}/bin/lok ${wallpapers}/icecold2.png";
      powerMenu = "${rofi-utils}/bin/rofi-power-menu";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      runInTerminal = "${pkgs.alacritty}/bin/alacritty -e";
      volumeControl = "${pkgs.pavucontrol}/bin/pavucontrol";
      wallpaper = "${wallpapers}/trees.jpg";

      windowManager = {
        name = "bspwm";
        reload = "${pkgs.bspwm}/bin/bspc wm -r";
        kill = "${pkgs.bspwm}/bin/bspc quit";
      };
    };
  };

  home-manager.users."${user.username}".gtk = {
    theme = {
      name = "Arc-Darker";
      package = pkgs.arc-theme;
    };

    #iconTheme = {
      #name = "Adwaita";
      #package = pkgs.gnome3.adwaita-icon-theme;
    #};

    #iconTheme = {
      #name = "Moka";
      #package = pkgs.moka-icon-theme;
    #};

    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };

  # ----------------------------------------------------------------------------
  # Settings
  # ----------------------------------------------------------------------------

  settings.users = [ user ];
}
