{ stdenv }:

stdenv.mkDerivation rec {
  name = "rofi-utils";
  version = "1.0.0";

  meta = {
    description = "Rofi menu utilities";
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
    install -vD $src/rofi-power-menu $out/bin/;
    install -vD $src/rofi-wifi-menu $out/bin/;
    install -vD $src/rofigen $out/bin/;
  '';
}
