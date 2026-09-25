{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "battery-monitor";
  text = builtins.readFile ./battery-monitor.sh;

  runtimeInputs = [
    pkgs.libnotify
    pkgs.coreutils
  ];
}
