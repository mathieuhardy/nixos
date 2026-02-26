{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "workspace-navigation";
  src = ./scripts/workspace-navigation.sh;

  buildInputs = [ pkgs.hyprland ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/workspace-navigation
    chmod +x $out/bin/workspace-navigation
  '';
}
