{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    file-roller # Archive manager
    gparted
    xarchiver
    xdg-user-dirs
  ];

  programs = {
    # For thunar to be able to save settings
    nix-ld = {
      enable = true;
      libraries = [ ];
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin # zip/unzip
        thunar-volman # mount volumes
      ];
    };
  };
}
