# Package for https://github.com/mathieuhardy/trash-monitor
#
# Installs the prebuilt binary published by the GitHub release workflow.
# To bump: change `version` and paste the content of the release's
# trash-monitor-x86_64-linux.tar.gz.sri file into `hash`.
{
  stdenv,
  fetchurl,
  autoPatchelfHook,
}:

stdenv.mkDerivation rec {
  pname = "trash-monitor";
  version = "1.0.0";

  src = fetchurl {
    url = "https://github.com/mathieuhardy/trash-monitor/releases/download/v${version}/trash-monitor-x86_64-linux.tar.gz";
    hash = "sha256-zsViFV/MZXpOmYaR+By5CMIZGdoms86Y15NUVPOIjGc=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    stdenv.cc.cc.lib
  ];

  installPhase = ''
    runHook preInstall
    install -Dm755 trash-monitor $out/bin/trash-monitor
    runHook postInstall
  '';

  meta = {
    description = "Monitor trash directory and emit JSON events for Waybar";
    homepage = "https://github.com/mathieuhardy/trash-monitor";
    platforms = [ "x86_64-linux" ];
    mainProgram = "trash-monitor";
  };
}
