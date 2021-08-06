{ pkgs, stdenv }:

stdenv.mkDerivation rec {
  name = "rice";
  version = "1.0.0";

  meta = {
    description = "Theme manager";
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
    install -vD $src/rice $out/bin/;
  '';
}
