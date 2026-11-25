# Package for https://github.com/mathieuhardy/koob
#
# Installs the prebuilt binary published by the GitHub release workflow.
# To bump: change `version` and paste the content of the release's
# koob-x86_64-linux.tar.gz.sri file into `hash`.
{
  stdenv,
  fetchurl,
  autoPatchelfHook,
}:

stdenv.mkDerivation rec {
  pname = "koob";
  version = "1.0.0";

  src = fetchurl {
    url = "https://github.com/mathieuhardy/koob/releases/download/v${version}/koob-x86_64-linux.tar.gz";
    hash = "sha256-GfdrNHgHvCasdOikw9FlzbnBkGLNnRKSPrcksZizAaE=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    stdenv.cc.cc.lib
  ];

  installPhase = ''
    runHook preInstall
    install -Dm755 koob $out/bin/koob
    runHook postInstall
  '';

  meta = {
    description = "Ebook management and conversion tool";
    homepage = "https://github.com/mathieuhardy/koob";
    platforms = [ "x86_64-linux" ];
    mainProgram = "koob";
  };
}
