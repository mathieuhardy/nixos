{ pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # User service for local LLMs
  # ────────────────────────────────────────────────────────────────────────────

  services.ollama = {
    enable = true;
    acceleration = false;
    loadModels = [ "mistral" ];
    # Optionnel, pour rendre la RAM plus vite après une session d'écriture :
    # environmentVariables.OLLAMA_KEEP_ALIVE = "5m";
  };
}
