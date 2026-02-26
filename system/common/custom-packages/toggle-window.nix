{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "toggle-window";
  src = ./scripts/toggle-window.sh;

  buildInputs = [ pkgs.hyprland ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/toggle-window
    chmod +x $out/bin/toggle-window
  '';
}
