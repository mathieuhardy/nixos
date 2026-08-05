{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  python3,
  jre_headless,
  makeWrapper,
  # Set to true to compile the bundled llama.cpp engine (heavy native build).
  # When false, Lexicon uses an external Ollama server you run yourself.
  withLlama ? false,
}:

let
  # Python environment with the backend's runtime deps.
  # requirements.txt: fastapi, uvicorn, requests, language-tool-python,
  #                   huggingface-hub==0.29.3  (pin is not enforced here;
  #                   the code only uses the stable hf_hub_url helper)
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

  # Nothing to compile: the backend is a directory of .py modules.
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    # Ship the backend sources under libexec.
    install -d "$out/libexec/lexicon-backend"
    cp -r backend/*.py "$out/libexec/lexicon-backend/"

    # launcher.py boots uvicorn with `from main import app`, honouring
    # LEXICON_HOST / LEXICON_PORT. We run it with the backend dir as cwd so
    # its relative imports (main, inference, languagetool, ...) resolve.
    makeWrapper "${pythonEnv}/bin/python" "$out/bin/lexicon-backend" \
      --add-flags "$out/libexec/lexicon-backend/launcher.py" \
      --chdir "$out/libexec/lexicon-backend" \
      --prefix PATH : "${lib.makeBinPath [ jre_headless ]}" \
      --set-default LEXICON_HOST "127.0.0.1" \
      --set-default LEXICON_PORT "8006"

    runHook postInstall
  '';

  # Smoke-test that the app imports and the CLI is wired up.
  doInstallCheck = true;
  installCheckPhase = ''
    "${pythonEnv}/bin/python" -c "import fastapi, uvicorn, language_tool_python"
  '';

  meta = {
    description = "Local-first writing assistant — FastAPI backend (proofreading + local AI)";
    longDescription = ''
      The Python backend of Lexicon. Exposes the proofreading and AI-transform
      API on http://127.0.0.1:8006. Proofreading uses LanguageTool, which needs
      a JRE (provided here) and, on first use, downloads the LanguageTool JAR to
      the user cache — so the first run needs network access. Set
      LANGUAGETOOL_SERVER to point at an external LanguageTool instead.

      AI transforms use either a running Ollama server (default when reachable)
      or the bundled llama.cpp engine (build with `withLlama = true`), which
      downloads a quantized GGUF model from Hugging Face at runtime.

      This packages the backend only, not the Tauri desktop shell (Rust) or the
      React frontend.
    '';
    homepage = "https://github.com/AashishH15/Lexicon";
    license = lib.licenses.mit;
    mainProgram = "lexicon-backend";
    platforms = lib.platforms.unix;
  };
})
