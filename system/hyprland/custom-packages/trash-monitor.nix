{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage {
  pname = "trash-monitor";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "mathieuhardy";
    repo = "trash-monitor";
    rev = "31e545adf62e8709dbe4ffc547a1bb2a3d4dc117";
    hash = "sha256-EqlKLNjPNG/FbVnWZPplpJ10okjTPYG91KH3xemnIi8=";
  };

  cargoHash = "sha256-Bd9cnp7DUlteJFwbskSpJzM9MMfbFnoLYyt7RFB/yn0=";

  meta = {
    description = "Monitoring of the trash directory for waybar";
    license = lib.licenses.mit;
    mainProgram = "trash-monitor";
  };
}
