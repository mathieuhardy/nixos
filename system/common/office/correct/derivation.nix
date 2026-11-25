# Package for https://github.com/mathieuhardy/correct
#
# Installs the prebuilt binary published by the GitHub release workflow.
# To bump: change `version` and paste the content of the release's
# correct-x86_64-linux.tar.gz.sri file into `hash`.
{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  makeWrapper,
  makeDesktopItem,
  copyDesktopItems,
  openssl,
  wayland,
  libGL,
  libxkbcommon,
  xorg,
}:

stdenv.mkDerivation rec {
  pname = "correct";
  version = "1.0.0";

  src = fetchurl {
    url = "https://github.com/mathieuhardy/correct/releases/download/v${version}/correct-x86_64-linux.tar.gz";
    hash = "sha256-zJv1NT7SZm+AEaEVT4tktOMtbv3kHeAMhMqARO3UZbY=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
    copyDesktopItems
  ];

  # Libraries linked at build time (patched by autoPatchelfHook)
  buildInputs = [
    openssl
    stdenv.cc.cc.lib
  ];

  desktopItems = [
    (makeDesktopItem {
      name = "correct";
      exec = "correct";
      icon = "correct";
      desktopName = "Correct";
      comment = "Correcteur orthographique et grammatical";
      categories = [
        "Office"
        "Utility"
      ];
      terminal = false;
    })
  ];

  installPhase = ''
    runHook preInstall

    install -Dm755 correct $out/bin/correct
    install -Dm644 icon.png $out/share/icons/hicolor/128x128/apps/correct.png

    runHook postInstall
  '';

  # Libraries loaded at runtime with dlopen (winit / glutin)
  postFixup = ''
    wrapProgram $out/bin/correct \
      --prefix LD_LIBRARY_PATH : ${
        lib.makeLibraryPath [
          wayland
          libGL
          libxkbcommon
          xorg.libX11
          xorg.libXcursor
          xorg.libXrandr
          xorg.libXi
        ]
      }
  '';

  meta = {
    description = "Correcteur orthographique et grammatical";
    homepage = "https://github.com/mathieuhardy/correct";
    platforms = [ "x86_64-linux" ];
    mainProgram = "correct";
  };
}
