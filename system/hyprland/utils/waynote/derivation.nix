# Package for https://github.com/mryll/waynote
#
# Installs the prebuilt binary published by the GitHub release workflow.
# To bump: change `version` and update `hash` with:
#   nix hash file --type sha256 <downloaded-binary>
{
  stdenv,
  fetchurl,
  autoPatchelfHook,
  gtk4-layer-shell,
  gtk4,
}:

stdenv.mkDerivation rec {
  pname = "waynote";
  version = "0.1.9";

  src = fetchurl {
    url = "https://github.com/mryll/waynote/releases/download/v${version}/waynote-${version}-x86_64-linux";
    hash = "sha256-7e5m5s6KufgQ4P0VUOsau1+ztFyj4F7xSQ2bcAov6ks=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    gtk4-layer-shell
    gtk4
    stdenv.cc.cc.lib
  ];

  dontUnpack = true;

  installPhase = ''
    runHook preInstall
    install -Dm755 $src $out/bin/waynote
    runHook postInstall
  '';

  meta = {
    description = "Wayland sticky notes";
    homepage = "https://github.com/mryll/waynote";
    platforms = [ "x86_64-linux" ];
    mainProgram = "waynote";
  };
}
