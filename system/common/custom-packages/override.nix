{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "override";
  src = ./scripts/override.sh;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/override
    chmod +x $out/bin/override
  '';
}
