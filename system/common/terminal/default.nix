{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
    wezterm
  ];
}
