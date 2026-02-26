{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "notifications-count";
  src = ./scripts/notifications-count.sh;
  dontUnpack = true;

  buildInputs = [ pkgs.swaynotificationcenter ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/notifications-count
    chmod +x $out/bin/notifications-count
  '';
}
