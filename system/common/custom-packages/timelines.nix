# Package for https://github.com/sreegjl/timelines
#
# The app is a Vite/React front-end wrapped in Electron. We build the
# front-end with `npm run build` (buildNpmPackage's default build phase),
# then run it with nixpkgs' own `electron` package instead of the prebuilt
# binary that the `electron` npm package would normally download — hence
# ELECTRON_SKIP_BINARY_DOWNLOAD, which keeps the whole build fully offline
# and sandbox-friendly.
{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  electron,
  makeDesktopItem,
  copyDesktopItems,
  makeWrapper,
}:

buildNpmPackage rec {
  pname = "timelines";
  version = "main";

  src = fetchFromGitHub {
    owner = "sreegjl";
    repo = "timelines";
    rev = "c74e5eceb8d89cdbfe7ea533da3beb90bea040f7";
    hash = "sha256-CgmLAGbZiIM9xYaDdJ6nLTUxUNOvL7fmg8CzNBexPkc="; # lib.fakeHash
  };

  npmDepsHash = "sha256-elBOJ2brpDn4CgWoGuh7wR5wD5atd7wIWQhM5/cv70A=";

  env.ELECTRON_SKIP_BINARY_DOWNLOAD = "1";

  # `npm run build` runs `vite build`, producing ./dist. It needs the
  # devDependencies (vite, @vitejs/plugin-react, ...), so only prune them
  # afterwards, once the build no longer needs them.
  postBuild = ''
    npm prune --omit=dev
  '';

  nativeBuildInputs = [
    makeWrapper
    copyDesktopItems
  ];

  desktopItems = [
    (makeDesktopItem {
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
    })
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/timelines $out/bin

    # electron/main.cjs resolves dist/ and public/ relative to its own
    # location, and package.json's "main" field points at electron/main.cjs,
    # so all of these need to stay siblings.
    cp -r dist electron public package.json node_modules $out/share/timelines/

    install -Dm644 public/favicon/icon.png \
      $out/share/icons/hicolor/512x512/apps/timelines.png

    makeWrapper ${electron}/bin/electron $out/bin/timelines \
      --add-flags $out/share/timelines

    copyDesktopItems

    runHook postInstall
  '';

  meta = {
    description = "Free, open-source app for creating interactive timelines for worldbuilding and history";
    homepage = "https://github.com/sreegjl/timelines";
    license = lib.licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "timelines";
  };
}
