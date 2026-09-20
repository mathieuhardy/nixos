{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    devcontainer
    meld
    tokei
  ];
}
