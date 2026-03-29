{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage {
  pname = "pirate-ctl";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "cesarferreira";
    repo = "pirate-ctl";
    rev = "4c4aa223c31e4fd08c17bd7f325361c9fb8b8143";
    hash = "sha256-6BjJ+iuZJynYdoWDtwNVTXLJ8NPWSNRN/8o5X38dzYI=";
  };

  cargoHash = "sha256-OOCpQrCFBh3myuQkhKyEnlXeNl33jK9nRU6sOeSqy14=";

  meta = {
    description = "Bittorent TUI";
    license = lib.licenses.mit;
    mainProgram = "pirate-ctl";
  };
}
