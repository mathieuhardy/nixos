{ fetchzip, pkgs, stdenv }:

stdenv.mkDerivation rec {
  name = "wallpapers";
  version = "1.0.0";

  meta = {
    description = "Collection of wallpapers";
    license = stdenv.lib.licenses.mit;
    platforms = stdenv.lib.platforms.all;
  };

  preferLocalBuild = true;

  nativeBuildInputs = [ pkgs.unzip ];

  buildInputs = [ pkgs.unzip ];

  src = fetchzip {
    url = "https://github.com/mathieuhardy/wallpapers/raw/main/wallpapers.zip";
    sha256 = "1nfvdkcf0k40bwg93d2d4xxvl82v1qf1dlhs8q3jmsf4rlad92yj";
    stripRoot = false;
  };

  phases = "preInstall installPhase";

  preInstall = ''
    mkdir -p $out;
  '';

  installPhase = ''
    install -vD $src/* $out/;
  '';
}
