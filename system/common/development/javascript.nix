{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fnm
    nodejs
  ];
}
