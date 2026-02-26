{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "toggle-bluetooth";
  src = ./scripts/toggle-bluetooth.sh;
  dontUnpack = true;

  buildInputs = [ ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/toggle-bluetooth
    chmod +x $out/bin/toggle-bluetooth
  '';
}
