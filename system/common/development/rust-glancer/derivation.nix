# Package for https://github.com/rust-glancer/rust-glancer
#
# Installs the prebuilt binary from the GitHub release.
# To bump: change `version` and update `hash` with:
#   nix-prefetch-url --unpack <url> | xargs nix hash to-sri --type sha256
{
  stdenv,
  fetchurl,
  autoPatchelfHook,
}:

stdenv.mkDerivation rec {
  pname = "rust-glancer";
  version = "0.5.2";

  src = fetchurl {
    url = "https://github.com/rust-glancer/rust-glancer/releases/download/v${version}/rust-glancer-x86_64-unknown-linux-gnu.tar.gz";
    hash = "sha256-DcWlmbAuNz8yy2N03cBoiO4kIZ8EJl60X1LPriqS9HI=";
  };

  sourceRoot = ".";

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    stdenv.cc.cc.lib
  ];

  installPhase = ''
    runHook preInstall
    install -Dm755 rust-glancer $out/bin/rust-glancer
    runHook postInstall
  '';

  meta = {
    description = "An experimental Rust LSP optimized for low memory usage";
    homepage = "https://github.com/rust-glancer/rust-glancer";
    platforms = [ "x86_64-linux" ];
    mainProgram = "rust-glancer";
  };
}
