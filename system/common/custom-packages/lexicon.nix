{ pkgs }:

let
  runtimeLibs = with pkgs; [
    gtk3
    glib
    cairo
    pango
    gdk-pixbuf
    atk
    nss
    nspr
    alsa-lib
    cups
    libxkbcommon
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libXi
    mesa
    expat
    dbus
    zlib
    sqlite
    webkitgtk_4_1
    libsoup_3
    libayatana-appindicator
  ];
in
pkgs.stdenv.mkDerivation {
  pname = "lexicon";
  version = "0.9.0";

  src = pkgs.fetchurl {
    url = "https://github.com/AashishH15/Lexicon/releases/download/v0.9.0/Lexicon_0.9.0_amd64.deb";
    hash = "sha256-izE40bVD6ZksZMh1mQDHp/coNv9GGHfuSGnacwkirsc=";
  };

  nativeBuildInputs = with pkgs; [
    dpkg
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = runtimeLibs;

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    mkdir -p $out/bin $out/lib $out/share
    cp -r usr/lib/Lexicon $out/lib/
    cp -r usr/share/* $out/share/ || true
    install -m755 usr/bin/lexicon $out/bin/.lexicon-unwrapped

    makeWrapper $out/bin/.lexicon-unwrapped $out/bin/lexicon \
      --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath runtimeLibs}
  '';
}
