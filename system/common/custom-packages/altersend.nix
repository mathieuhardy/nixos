{
  lib,
  stdenv,
  fetchFromGitHub,
  buildNpmPackage,
  electron,
  makeWrapper,
  copyDesktopItems,
  makeDesktopItem,
}:

buildNpmPackage rec {
  pname = "altersend";
  version = "1.8.0";

  src = fetchFromGitHub {
    owner = "denislupookov";
    repo = "altersend";
    rev = "v${version}";
    hash = "sha256-bPcgOk2iDevcYlKxDJWb8b17n3BulW7dJ0veVkoBQgs=";
  };

  npmDepsHash = "sha256-QLqJBSqgfzCAeJix9zTokBYpQOOhP26OWAmqSsDRnNw=";

  nativeBuildInputs = [
    makeWrapper
    copyDesktopItems
  ];

  npmBuildScript = "build";

  env = {
    ELECTRON_SKIP_BINARY_DOWNLOAD = "1";
    PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = "1";
    CYPRESS_INSTALL_BINARY = "0";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/altersend
    mkdir -p $out/bin

    # Adapter si le workspace produit ailleurs.
    cp -r apps/desktop/dist/* $out/share/altersend/

    makeWrapper ${electron}/bin/electron $out/bin/altersend \
      --add-flags "$out/share/altersend"

    if [ -d apps/desktop/resources ]; then
      mkdir -p $out/share
      cp -r apps/desktop/resources $out/share/altersend-resources
    fi

    if [ -f apps/desktop/build/icon.png ]; then
      mkdir -p $out/share/icons/hicolor/512x512/apps
      cp apps/desktop/build/icon.png \
        $out/share/icons/hicolor/512x512/apps/altersend.png
    fi

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "altersend";
      desktopName = "AlterSend";
      exec = "altersend";
      icon = "altersend";
      terminal = false;
      categories = [
        "Network"
        "Utility"
      ];
    })
  ];

  meta = with lib; {
    description = "Desktop client for AlterSend";
    homepage = "https://github.com/denislupookov/altersend";
    license = licenses.mit;
    maintainers = [ ];
    platforms = platforms.linux;
    mainProgram = "altersend";
  };
}
