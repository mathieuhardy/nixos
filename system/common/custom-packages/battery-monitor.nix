{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "battery-monitor";
  src = ./scripts/battery-monitor.sh;

  buildInputs = [ pkgs.libnotify ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/battery-monitor
    chmod +x $out/bin/battery-monitor
  '';
}
