{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "git-dirty-repos";
  src = ./scripts/git-dirty-repos.sh;
  dontUnpack = true;

  buildInputs = [ pkgs.git ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/git-dirty-repos
    chmod +x $out/bin/git-dirty-repos
  '';
}
