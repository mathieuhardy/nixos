{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "alt-f4";
  src = ./scripts/alt-f4.sh;
  dontUnpack = true;

  buildInputs = [ ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/alt-f4
    chmod +x $out/bin/alt-f4
  '';
}
