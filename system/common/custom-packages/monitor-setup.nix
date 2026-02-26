{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "monitor-setup";
  src = ./scripts/monitor-setup.sh;

  buildInputs = [ pkgs.hyprland ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/monitor-setup
    chmod +x $out/bin/monitor-setup
  '';
}
