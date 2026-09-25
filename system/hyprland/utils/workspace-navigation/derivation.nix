{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "workspace-navigation";
  text = builtins.readFile ./workspace-navigation.sh;

  runtimeInputs = [
    pkgs.hyprland
    pkgs.jq
  ];
}
