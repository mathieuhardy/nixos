{ pkgs, stdenv }:

stdenv.mkDerivation rec {
  name = "override";
  version = "1.0.0";

  meta = {
    description = "Override NixOS configuration";
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
    install -vD $src/override $out/bin/;
  '';
}
