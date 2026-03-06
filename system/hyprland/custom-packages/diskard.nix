{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage {
  pname = "diskard";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "shoenot";
    repo = "diskard";
    rev = "d26042580c5d4df407bc2fa3af17ac82149326d1";
    hash = "sha256-N1Fm9JGWM5UdrKaRnfAEOPJSv4zzwz8AEeo0/i5PL58=";
  };

  cargoHash = "sha256-Mj1jnyuowXTipUoEHPbk/U+5kW29GwqsX7lxPpJCHXY=";

  meta = {
    description = "Disk Usage Analyzer and recursive deleter";
    license = lib.licenses.mit;
    mainProgram = "diskard";
  };
}
