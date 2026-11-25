# Package for https://github.com/mathieuhardy/storyteller
#
# Installs the prebuilt binary published by the GitHub release workflow.
# To bump: change `version` and paste the content of the release's
# storyteller-x86_64-linux.tar.gz.sri file into `hash`.
{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  wrapGAppsHook3,
  copyDesktopItems,
  makeDesktopItem,
  webkitgtk_4_1,
  gtk3,
  libayatana-appindicator,
  librsvg,
  openssl,
}:

stdenv.mkDerivation rec {
  pname = "storyteller";
  version = "1.0.0";

  src = fetchurl {
    url = "https://github.com/mathieuhardy/storyteller/releases/download/v${version}/storyteller-x86_64-linux.tar.gz";
    hash = "sha256-nXQfmnuZ/QlFEc2nAx2x+ltiN6KQtxLyPNNVAvpH+aE=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    wrapGAppsHook3
    copyDesktopItems
  ];

  buildInputs = [
    stdenv.cc.cc.lib
    openssl
    webkitgtk_4_1
    gtk3
    libayatana-appindicator
    librsvg
  ];

  desktopItems = [
    (makeDesktopItem {
      name = "storyteller";
      exec = "storyteller";
      icon = "storyteller";
      desktopName = "Storyteller";
      comment = "Personal knowledge base";
      categories = [
        "Office"
        "Utility"
      ];
    })
  ];

  installPhase = ''
    runHook preInstall

    install -Dm755 storyteller $out/bin/storyteller
    install -Dm644 icon.png $out/share/icons/hicolor/128x128/apps/storyteller.png

    runHook postInstall
  '';

  # Force X11 backend to work around webkit2gtk rendering issues on Wayland
  preFixup = ''
    gappsWrapperArgs+=(--set GDK_BACKEND x11)
  '';

  meta = {
    description = "Personal knowledge base";
    homepage = "https://github.com/mathieuhardy/storyteller";
    platforms = [ "x86_64-linux" ];
    mainProgram = "storyteller";
  };
}
