{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zed-editor # Backup editor
  ];

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
