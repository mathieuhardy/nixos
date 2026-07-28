{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "git-commit-push";
  src = ./scripts/git-commit-push.sh;
  dontUnpack = true;

  buildInputs = [ pkgs.git ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/git-commit-push
    chmod +x $out/bin/git-commit-push
  '';
}
