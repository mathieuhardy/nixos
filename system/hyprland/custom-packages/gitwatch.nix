{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage {
  pname = "gitwatch";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "mathieuhardy";
    repo = "gitwatch";
    rev = "7ea65f524ab79fc12ab1b709f59098ae12b977bd";
    hash = lib.fakeHash;
  };

  cargoHash = lib.fakeHash;

  meta = {
    description = "Monitoring of the Git repositories for waybar";
    license = lib.licenses.mit;
    mainProgram = "gitwatch";
  };
}
