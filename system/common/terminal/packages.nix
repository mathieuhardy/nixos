{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty # Backup terminal
    wezterm
  ];
}
