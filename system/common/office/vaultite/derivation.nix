{ pkgs, ... }:

pkgs.appimageTools.wrapType2 {
  pname = "vaultite";
  version = "0.13.0";
  src = pkgs.fetchurl {
    url = "https://github.com/Vaultite/vaultite/releases/download/v0.13.0/Vaultite-0.13.0-x86_64.AppImage";
    hash = "sha256-Lx1/4UQlHU57YHfMpzVt3Rtw3Y53GL0VMqGoF+EWUIk=";
  };
  extraInstallCommands = ''
    install -m 444 -D ${./vaultite.desktop} $out/share/applications/vaultite.desktop
    install -m 444 -D ${./vaultite.svg} $out/share/icons/hicolor/scalable/apps/vaultite.svg
  '';
}
