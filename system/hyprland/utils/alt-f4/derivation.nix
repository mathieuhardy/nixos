{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "alt-f4";
  text = builtins.readFile ./alt-f4.sh;

  runtimeInputs = [
    pkgs.hyprland
    pkgs.jq
  ];
}
