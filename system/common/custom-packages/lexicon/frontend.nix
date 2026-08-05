{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage (finalAttrs: {
  pname = "lexicon-frontend";
  version = "0.8.5";

  # Same repo/rev as the backend — keep these two derivations pinned together.
  src = fetchFromGitHub {
    owner = "AashishH15";
    repo = "Lexicon";
    rev = "fe887e68cb384fffb6753d26041c1e9693bbc068";
    hash = "sha256-PEjxj+M9Z6t2ubN13xgvXZURgJTEreHEuwgbOQywqU8=";
  };

  # Only the frontend/ subtree is an npm project; package-lock.json lives there.
  sourceRoot = "${finalAttrs.src.name}/frontend";

  # PLACEHOLDER — first build will fail and print the real hash to paste here.
  # (I can't run `prefetch-npm-deps` from where I generated this, since that
  # needs nixpkgs itself; this is the one hash you'll need to fill in.)
  npmDepsHash = "sha256-Ii1ANwZw8B6+bniZnJkNstyGwNGhfLO/TIjQokjZW9U=";

  # No devDependencies needed at runtime; this is a static build.
  npmBuildScript = "build";

  # `vite build` writes to frontend/dist by default (see vite config / tauri.conf.json's
  # `frontendDist: "../dist"`, relative to frontend/src-tauri).
  installPhase = ''
    runHook preInstall
    cp -r dist $out
    runHook postInstall
  '';

  meta = {
    description = "Lexicon desktop UI — React/Vite static build (used by both `tauri build` and the Nix Tauri package)";
    homepage = "https://github.com/AashishH15/Lexicon";
    license = lib.licenses.mit;
  };
})
