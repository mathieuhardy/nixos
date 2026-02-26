{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "trash-count";
  src = ./scripts/trash-count.sh;

  buildInputs = [];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/trash-count
    chmod +x $out/bin/trash-count
  '';
}
