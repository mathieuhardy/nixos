{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "toggle-window";
  text = builtins.readFile ./toggle-window.sh;

  runtimeInputs = [
    pkgs.hyprland
    pkgs.jq
  ];
}
