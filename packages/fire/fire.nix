{ stdenv }:

stdenv.mkDerivation rec {
  name = "fire";
  version = "1.0.0";

  meta = {
    description = "Command launcher";
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
    install -vD $src/fire $out/bin/;
    install -vD $src/restart $out/bin/;
    install -vD $src/start $out/bin/;
    install -vD $src/stop $out/bin/;
    install -vD $src/toggle $out/bin/;
  '';
}
