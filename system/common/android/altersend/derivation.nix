{
  lib,
  appimageTools,
  fetchurl,
  makeDesktopItem,
}:

let
  pname = "altersend";
  version = "2.1.0";

  desktopItem = makeDesktopItem {
    name = pname;
    exec = pname;
    icon = pname;
    desktopName = "AlterSend";
    comment = "AlterSend - Share files with Android";
    categories = [ "Utility" ];
  };
in
appimageTools.wrapType2 {
  inherit pname version;

  src = fetchurl {
    url = "https://github.com/denislupookov/altersend/releases/download/v${version}/AlterSend-x86_64.AppImage";
    sha256 = "sha256-aXhjsgtBwnBRmlm7CZR7XOauCgudWDaBIGzJp1WVbYo=";
  };

  extraPkgs = pkgs: with pkgs; [ ];

  extraInstallCommands = ''
    install -Dm444 ${desktopItem}/share/applications/${pname}.desktop \
      $out/share/applications/${pname}.desktop

    install -Dm444 ${./altersend.png} \
      $out/share/icons/hicolor/512x512/apps/${pname}.png
  '';

  meta = with lib; {
    description = "AlterSend";
    homepage = "https://github.com/denislupookov/altersend";
    platforms = [ "x86_64-linux" ];
  };
}
