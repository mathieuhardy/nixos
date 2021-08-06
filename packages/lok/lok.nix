{ pkgs, stdenv }:

stdenv.mkDerivation rec {
  name = "lok";
  version = "1.0.0";

  meta = {
    description = "Session locking scripts based on i3lock-color";
    license = stdenv.lib.licenses.mit;
    platforms = stdenv.lib.platforms.all;
  };

  dontUnpack = true;
  preferLocalBuild = true;

  src = ./resources;

  phases = "preInstall installPhase";

  preInstall = ''
    mkdir -p $out/bin;
  '';

  installPhase = ''
    install -vD $src/lok $out/bin/;
  '';
}
