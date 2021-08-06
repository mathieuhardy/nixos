{ stdenv }:

stdenv.mkDerivation rec {
  name = "easier";
  version = "1.0.0";

  meta = {
    description = "Pure shell framework";
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
    install -vD $src/easier.sh $out/;
    install -vD $src/easier_cli.sh $out/;
    install -vD $src/easier_fs.sh $out/;
    install -vD $src/easier_logging.sh $out/;
    install -vD $src/easier_number.sh $out/;
    install -vD $src/easier_string.sh $out/;
    install -vD $src/easier_test.sh $out/;
    install -vD $src/easier_various.sh $out/;
  '';
}
