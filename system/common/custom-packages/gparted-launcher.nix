{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "gparted-launcher";
  src = ./scripts/gparted-launcher.sh;
  dontUnpack = true;

  buildInputs = [ ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/gparted-launcher
    chmod +x $out/bin/gparted-launcher
  '';
}
