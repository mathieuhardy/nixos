{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "toggle-bluetooth";
  text = builtins.readFile ./toggle-bluetooth.sh;

  runtimeInputs = [
    pkgs.bluez
  ];
}
