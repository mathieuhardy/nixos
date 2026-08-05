{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  wrapGAppsHook3,
  at-spi2-atk,
  atkmm,
  cairo,
  gdk-pixbuf,
  glib,
  gtk3,
  harfbuzz,
  librsvg,
  libsoup_3,
  libayatana-appindicator,
  openssl,
  pango,
  webkitgtk_4_1,
  lexicon-frontend,
  lexicon-backend,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "lexicon";
  version = "0.8.5";

  # Same repo/rev as the backend and frontend derivations — keep all three pinned together.
  src = fetchFromGitHub {
    owner = "AashishH15";
    repo = "Lexicon";
    rev = "fe887e68cb384fffb6753d26041c1e9693bbc068";
    hash = "sha256-PEjxj+M9Z6t2ubN13xgvXZURgJTEreHEuwgbOQywqU8=";
  };

  # The upstream repo does not commit a Cargo.lock for frontend/src-tauri (it's
  # gitignored). This one was produced with `cargo generate-lockfile` against
  # the pinned rev above — regenerate it if you bump `rev`.
  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  # Cargo.toml lives in frontend/src-tauri, but tauri's build.rs / generate_context!()
  # macro embeds ../dist relative to it (frontend/dist) at *compile time*, so we can't
  # just cd into the subdir and lose the rest of the tree — buildAndTestSubdir keeps
  # the full source layout while still building the right crate.
  #
  # cargoRoot is the separate knob cargoSetupHook itself uses to know where the
  # crate (and therefore Cargo.lock) lives; without it, cargoSetupPostPatchHook
  # looks for Cargo.lock at the unpacked source *root* and fails, even though
  # buildAndTestSubdir is set correctly for the actual build/test/install phases.
  cargoRoot = "frontend/src-tauri";
  buildAndTestSubdir = "frontend/src-tauri";

  # Rewrites start_backend() in main.rs to drop the PyInstaller-sidecar /
  # resource_dir() lookup (see lexicon-backend-path.patch for the diff).
  # Kept as a static file, not an inline substituteInPlace block: Nix's
  # indented ''...'' strings dedent on the *whole* string, which silently
  # mangles the leading whitespace of a big pasted-in Rust block.
  patches = [ ./lexicon-backend-path.patch ];

  postPatch = ''
    # Drop the built frontend where tauri::generate_context!() expects it
    # (frontend/src-tauri/../dist == frontend/dist).
    cp -r ${lexicon-frontend} frontend/dist
    chmod -R u+w frontend/dist

    # Upstream gitignores Cargo.lock for frontend/src-tauri, so the unpacked
    # source has none at all. cargoSetupPostPatchHook diffs whatever's already
    # in the tree against the lock file used for vendoring rather than just
    # dropping ours in — so put it there ourselves first.
    cp ${./Cargo.lock} frontend/src-tauri/Cargo.lock
    chmod u+w frontend/src-tauri/Cargo.lock

    # Single-line substitution only (safe from the dedent issue above): fill
    # in the real Nix store path for the backend the patch left as a marker.
    substituteInPlace frontend/src-tauri/src/main.rs \
      --replace-fail '@LEXICON_BACKEND_BIN@' '${lexicon-backend}/bin/lexicon-backend'
  '';

  nativeBuildInputs = [
    pkg-config
    wrapGAppsHook3
  ];

  buildInputs = [
    at-spi2-atk
    atkmm
    cairo
    gdk-pixbuf
    glib
    gtk3
    harfbuzz
    librsvg
    libsoup_3
    libayatana-appindicator
    openssl
    pango
    webkitgtk_4_1
  ];

  # No display server / keychain in the sandbox; this is a GUI app.
  doCheck = false;

  meta = {
    description = "Lexicon — privacy-first grammar and AI writing assistant (Tauri desktop shell)";
    homepage = "https://github.com/AashishH15/Lexicon";
    license = lib.licenses.mit;
    mainProgram = "lexicon";
    platforms = lib.platforms.linux;
  };
})
