# Source for https://github.com/ilyamiro/Ski
#
# To bump: change `version` and update `sha256` with:
#   nix-prefetch-url --unpack https://github.com/ilyamiro/Ski/archive/refs/tags/v<version>.tar.gz
{ version, sha256 }:

builtins.fetchTarball {
  url = "https://github.com/ilyamiro/Ski/archive/refs/tags/v${version}.tar.gz";
  inherit sha256;
}
