{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  python3,
  jre_headless,
  makeWrapper,
  withLlama ? false,
}:
let
  pythonEnv = python3.withPackages (
    ps:
    [
      ps.fastapi
      ps.uvicorn
      ps.requests
      ps.huggingface-hub
      ps.language-tool-python
      ps.pydantic
    ]
    ++ lib.optional withLlama ps.llama-cpp-python
  );
in
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "lexicon-backend";
  version = "unstable-2026-08-05";
  src = fetchFromGitHub {
    owner = "AashishH15";
    repo = "Lexicon";
    rev = "fe887e68cb384fffb6753d26041c1e9693bbc068";
    hash = "sha256-PEjxj+M9Z6t2ubN13xgvXZURgJTEreHEuwgbOQywqU8=";
  };
  nativeBuildInputs = [ makeWrapper ];
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    runHook preInstall
    install -d "$out/libexec/lexicon-backend"
    cp -r backend/*.py "$out/libexec/lexicon-backend/"
    makeWrapper "${pythonEnv}/bin/python" "$out/bin/lexicon-backend" \
      --add-flags "$out/libexec/lexicon-backend/launcher.py" \
      --chdir "$out/libexec/lexicon-backend" \
      --prefix PATH : "${lib.makeBinPath [ jre_headless ]}" \
      --set-default LEXICON_HOST "127.0.0.1" \
      --set-default LEXICON_PORT "8000"
    runHook postInstall
  '';
  doInstallCheck = true;
  installCheckPhase = ''
    "${pythonEnv}/bin/python" -c "import fastapi, uvicorn, language_tool_python"
  '';
  meta = {
    description = "Local-first writing assistant — FastAPI backend (proofreading + local AI)";
    homepage = "https://github.com/AashishH15/Lexicon";
    license = lib.licenses.mit;
    mainProgram = "lexicon-backend";
    platforms = lib.platforms.unix;
  };
})
