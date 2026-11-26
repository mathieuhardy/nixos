{ pkgs, ... }:

pkgs.appimageTools.wrapType2 {
  pname = "vaultite";
  version = "0.15.0";
  src = pkgs.fetchurl {
    url = "https://github.com/Vaultite/vaultite/releases/download/v0.15.0/Vaultite-0.15.0-x86_64.AppImage";
    hash = "sha256-HaP8TSaDSB9WQtllB2wv3D3OYirpVMsD+tKuZj6BmxQ=";
  };
  extraInstallCommands = ''
    install -m 444 -D ${./vaultite.desktop} $out/share/applications/vaultite.desktop
    install -m 444 -D ${./vaultite.svg} $out/share/icons/hicolor/scalable/apps/vaultite.svg
  '';
}
