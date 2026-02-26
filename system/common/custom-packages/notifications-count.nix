{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "notifications-count";
  src = ./scripts/notifications-count.sh;

  buildInputs = [ pkgs.swaync ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/notifications-count
    chmod +x $out/bin/notifications-count
  '';
}
