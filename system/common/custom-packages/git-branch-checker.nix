{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "git-branch-checker";
  src = ./scripts/git-branch-checker.sh;

  buildInputs = [ pkgs.git ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/git-branch-checker
    chmod +x $out/bin/git-branch-checker
  '';
}
