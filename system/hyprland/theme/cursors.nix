{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    numix-cursor-theme
  ];
}
