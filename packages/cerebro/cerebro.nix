{ fetchFromGitHub, lib, pkgs, rustPlatform, stdenv }:

let
  maintainer = {
    name = "Mathieu Hardy";
    email = "mhardy2008@gmail.com";
  };
in
rustPlatform.buildRustPackage rec {
  name = "cerebro-${version}";
  version = "1.0.0";

  meta = {
    description = "System monitoring daemon";
    homepage = https://github.com/mathieuhardy/cerebro;
    licence = stdenv.lib.licenses.mit;
    maintainers = [ maintainer ];
    platforms = stdenv.lib.platforms.all;
  };

  src = fetchFromGitHub {
    owner = "mathieuhardy";
    repo = "cerebro";
    rev = "022c465fbaa9dd8a6e3bb0c3b27a0fe2e7ff5997";
    sha256 = "14cbm87scqmivn50g51k0m5md3f0jaffizl7ms0wm268k5kj30q9";
    #sha256 = lib.fakeSha256;
  };

  nativeBuildInputs = with pkgs; [
    pkg-config
  ];

  buildInputs = with pkgs; [
    lm_sensors
    fuse
  ];

  checkPhase = "";
  cargoSha256 = "sha256:063z0kqs1vw5yy04nd3n6pcckwaacv5dralnn150i0rvymcbcys9";
  #cargoSha256 = lib.fakeSha256;
}
