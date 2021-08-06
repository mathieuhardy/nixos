{ stdenv }:

stdenv.mkDerivation rec {
  name = "battery-mode";
  version = "1.0.0";

  meta = {
    description = "Battery profil configuration";
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
    install -vD $src/battery-mode $out/bin/;
  '';
}
