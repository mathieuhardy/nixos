# Package for https://github.com/mathieuhardy/hyprmonitors
#
# Installs the prebuilt binaries published by the GitHub release workflow.
# To bump: change `version` and paste the content of the release's
# hyprmonitors-x86_64-linux.tar.gz.sri file into `hash`.
{
  stdenv,
  fetchurl,
  autoPatchelfHook,
}:

stdenv.mkDerivation rec {
  pname = "hyprmonitors";
  version = "1.0.0";

  src = fetchurl {
    url = "https://github.com/mathieuhardy/hyprmonitors/releases/download/v${version}/hyprmonitors-x86_64-linux.tar.gz";
    hash = "sha256-Q2ZqiZUYq+a0Y9jAfzGdr+rZDhvV3jtozQD5orVWAKw=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    stdenv.cc.cc.lib
  ];

  installPhase = ''
    runHook preInstall
    install -Dm755 hyprmonitors $out/bin/hyprmonitors
    install -Dm755 hyprmonitors-tui $out/bin/hyprmonitors-tui
    runHook postInstall
  '';

  meta = {
    description = "Hyprland monitor configuration manager";
    homepage = "https://github.com/mathieuhardy/hyprmonitors";
    platforms = [ "x86_64-linux" ];
    mainProgram = "hyprmonitors";
  };
}
