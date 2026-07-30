# notediscovery.nix
#
# Module NixOS pour déployer NoteDiscovery (https://github.com/gamosoft/NoteDiscovery)
# via un conteneur OCI (podman), SANS Docker Desktop.
#
#   imports = [ ./notediscovery.nix ];
#   puis: sudo nixos-rebuild switch
#
# Gère :
#   1. Le serveur (conteneur OCI)
#   2. La langue FR pour la correction orthographique (dictionnaires système)
#
{
  config,
  pkgs,
  lib,
  ...
}:

let
  ##########################################################################
  # Réglages faciles à modifier
  ##########################################################################

  image = "ghcr.io/gamosoft/notediscovery:latest";

  # Tes notes vivent directement dans ton dossier perso (chemin ABSOLU obligatoire :
  # pas de ~ ni $HOME, la config est évaluée par root pendant nixos-rebuild).
  notesDir = "/home/${config.settings.userLogin}/${config.settings.repos}/notes";

  # UID:GID avec lequel le conteneur tourne, pour que les fichiers créés par
  # l'appli t'appartiennent (et pas à root). Vérifie avec `id` si besoin.
  runAs = "1000:1000";

  # Local uniquement (recommandé). Pour le LAN : "0.0.0.0:8005:8005" + firewall.
  portMapping = "127.0.0.1:8005:8005";

  ##########################################################################
  # config.yaml (généré, monté en lecture seule)
  ##########################################################################
  configYaml = pkgs.writeText "notediscovery-config.yaml" ''
    app:
      name: "NoteDiscovery"

    server:
      host: "0.0.0.0"        # à l'intérieur du conteneur
      port: 8005
      reload: false
      allowed_origins: ["*"]
      debug: false

    storage:
      notes_dir: "./data"
      plugins_dir: "./plugins"

    search:
      enabled: true

    ui:
      autosave_delay_ms: 1000

    authentication:
      enabled: false
      secret_key: "change_this_to_a_random_secret_key"
      password: "admin"
      session_max_age: 604800
      api_key: ""
  '';

in
{
  ##########################################################################
  # 2. Langue FR pour la correction orthographique (dictionnaires navigateur)
  #    Interface : Réglages -> Langue -> Français (locale fr fournie).
  ##########################################################################
  environment.systemPackages = with pkgs; [
    hunspellDicts.fr-any
    aspellDicts.fr
  ];

  ##########################################################################
  # 1. Le serveur
  ##########################################################################
  virtualisation.podman.enable = true;
  virtualisation.oci-containers.backend = "podman";

  virtualisation.oci-containers.containers.notediscovery = {
    inherit image;
    autoStart = true;
    ports = [ portMapping ];

    # Le conteneur tourne avec ton UID:GID => fichiers écrits dans ~/dev/notes
    # t'appartiennent, éditables directement avec ton éditeur.
    user = runAs;

    volumes = [
      # Tes notes, depuis ton dossier perso
      "${notesDir}:/app/data"
      # Config déclarative
      "${configYaml}:/app/config.yaml:ro"
    ];

    environment = {
      PORT = "8005";
    };
  };

  ##########################################################################
  # S'assure que le dossier de notes existe, avec le bon propriétaire.
  # (N'écrase rien s'il existe déjà et n'agit pas récursivement.)
  ##########################################################################
  systemd.tmpfiles.rules = [
    "d ${notesDir} 0750 1000 1000 - -"
  ];

  # networking.firewall.allowedTCPPorts = [ 8005 ];  # si accès LAN
}
