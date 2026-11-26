{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  gcc-unwrapped,
}:

let
  version = "0.2.0";

  arch = {
    "x86_64-linux" = {
      url = "https://github.com/cesarferreira/pirata/releases/download/v${version}/pirata-x86_64-unknown-linux-gnu.tar.gz";
      hash = "sha256-urGnoayxfHAABD1L66L0yooJT9RYj0rzFQzHH9MYdpQ=";
    };
    "aarch64-linux" = {
      url = "https://github.com/cesarferreira/pirata/releases/download/v${version}/pirata-aarch64-unknown-linux-gnu.tar.gz";
      hash = "sha256-Q83fOVSFPOBAQfoIY1qZ49368oY71uu8A8Ztihez9yQ=";
    };
  }.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
in

stdenv.mkDerivation {
  pname = "pirata";
  inherit version;

  src = fetchurl {
    inherit (arch) url hash;
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ gcc-unwrapped.lib ];

  dontConfigure = true;
  dontBuild = true;

  unpackPhase = ''
    tar xzf $src
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp pirata $out/bin/
  '';

  meta = {
    description = "BitTorrent TUI";
    license = lib.licenses.mit;
    mainProgram = "pirata";
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
    ];
  };
}
