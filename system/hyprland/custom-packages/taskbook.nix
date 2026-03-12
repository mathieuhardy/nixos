{ pkgs, ... }:

pkgs.stdenvNoCC.mkDerivation rec {
  pname = "taskbook";
  version = "1.3.2";
  target = "linux-x86_64";

  src = pkgs.fetchurl {
    url = "https://github.com/taskbook-sh/${pname}/releases/download/v${version}/tb-${target}.tar.gz";
    sha256 = "sha256-utqei0ieUf99Mp/fLTUJfQG3jj7VlTo2ZiDanXPUODg=";
  };

  dontBuild = true;

  unpackPhase = ''
    tar -xzf $src
  '';

  installPhase = ''
    mkdir -p $out/bin
    install -m755 tb $out/bin/tb
  '';
}
