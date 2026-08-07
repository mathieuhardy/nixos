{
  lib,
  appimageTools,
  fetchurl,
  makeDesktopItem,
}:

let
  pname = "altersend";
  version = "1.8.0";

  desktopItem = makeDesktopItem {
    name = pname;
    exec = pname;
    icon = pname;
    desktopName = "AlterSend";
    comment = "AlterSend - description de l'app";
    categories = [ "Utility" ];
  };
in
appimageTools.wrapType2 {
  inherit pname version;

  src = fetchurl {
    url = "https://github.com/denislupookov/altersend/releases/download/v${version}/AlterSend-x86_64.AppImage";
    sha256 = "2b429aedad7bf96aa693d544715bfc582f1c90fde47e8b503aa9b8157d613656";
  };

  extraPkgs = pkgs: with pkgs; [ ];

  extraInstallCommands = ''
    install -Dm444 ${desktopItem}/share/applications/${pname}.desktop \
      $out/share/applications/${pname}.desktop

    install -Dm444 ${./assets/altersend.png} \
      $out/share/icons/hicolor/512x512/apps/${pname}.png
  '';

  meta = with lib; {
    description = "AlterSend";
    homepage = "https://github.com/denislupookov/altersend";
    platforms = [ "x86_64-linux" ];
  };
}
