{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage {
  pname = "diskard";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "shoenot";
    repo = "diskard";
    rev = "v0.1.3";
    hash = "sha256-dr7/nIK4ELPkmEhpICGgMSnhkJXVjDqPFP7UugWZ2yk=";
  };

  cargoHash = "sha256-evlQxFS3X/kW1u9TTDfiAQMMSpWYksuHId69SliOLzY=";

  meta = {
    description = "Disk Usage Analyzer and recursive deleter";
    license = lib.licenses.mit;
    mainProgram = "diskard";
  };
}
