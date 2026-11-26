{
  lib,
  appimageTools,
  fetchurl,
  makeDesktopItem,
}:

let
  version = "0.9.0-alpha.1";

  src = fetchurl {
    url = "https://github.com/sreegjl/timelines/releases/download/v${version}/Timelines-${version}-Setup.AppImage";
    hash = "sha256-iJQTU7nL5dWzx48/PMeb2y+bQDkUy2TSc6Y40H1xmXg=";
  };

  appimageContents = appimageTools.extract {
    pname = "timelines";
    inherit version src;
  };

  desktopItem = makeDesktopItem {
    name = "timelines";
    exec = "timelines %U";
    icon = "timelines";
    desktopName = "Timelines";
    genericName = "Interactive timeline editor";
    comment = "Free, open-source app for creating interactive timelines for worldbuilding and history";
    categories = [
      "Office"
      "Utility"
    ];
  };
in

appimageTools.wrapType2 {
  pname = "timelines";
  inherit version src;

  extraInstallCommands = ''
    install -Dm644 ${desktopItem}/share/applications/timelines.desktop \
      $out/share/applications/timelines.desktop
    install -Dm644 ${appimageContents}/timelines.png \
      $out/share/icons/hicolor/512x512/apps/timelines.png
  '';

  meta = {
    description = "Free, open-source app for creating interactive timelines for worldbuilding and history";
    homepage = "https://github.com/sreegjl/timelines";
    license = lib.licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "timelines";
  };
}
