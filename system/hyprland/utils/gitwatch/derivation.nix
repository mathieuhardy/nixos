# Package for https://github.com/mathieuhardy/gitwatch
#
# Installs the prebuilt binary published by the GitHub release workflow.
# To bump: change `version` and paste the content of the release's
# gitwatch-x86_64-linux.tar.gz.sri file into `hash`.
{
  stdenv,
  fetchurl,
  autoPatchelfHook,
}:

stdenv.mkDerivation rec {
  pname = "gitwatch";
  version = "1.0.0";

  src = fetchurl {
    url = "https://github.com/mathieuhardy/gitwatch/releases/download/v${version}/gitwatch-x86_64-linux.tar.gz";
    hash = "sha256-iAjgu2o82xFlep3F/A80XtcG3gsW2xIsd3yCHG8ihbg=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    stdenv.cc.cc.lib
  ];

  installPhase = ''
    runHook preInstall
    install -Dm755 gitwatch $out/bin/gitwatch
    runHook postInstall
  '';

  meta = {
    description = "Monitor a directory of git repos for Waybar/rofi and auto-sync with conflict handling";
    homepage = "https://github.com/mathieuhardy/gitwatch";
    platforms = [ "x86_64-linux" ];
    mainProgram = "gitwatch";
  };
}
