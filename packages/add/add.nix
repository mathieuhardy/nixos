{ makeWrapper, pkgs, stdenv }:

let
  easier = pkgs.callPackage ../easier/easier.nix {};
in
stdenv.mkDerivation rec {
  name = "add";
  version = "1.0.0";

  meta = {
    description = "Pure shell file and directory creator";
    license = stdenv.lib.licenses.mit;
    platforms = stdenv.lib.platforms.all;
  };

  dontUnpack = true;
  preferLocalBuild = true;

  src = ./resources;

  nativeBuildInputs = [
    makeWrapper
  ];

  phases = "preInstall installPhase";

  preInstall = ''
    mkdir -p $out/bin;
  '';

  installPhase = ''
    makeWrapper $src/add $out/bin/add --prefix PATH : ${easier}
  '';
}
