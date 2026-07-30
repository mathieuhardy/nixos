{
  config,
  lib,
  pkgs,
  ...
}:

let
  version = "0.24.2";

  src = pkgs.fetchFromGitHub {
    owner = "gamosoft";
    repo = "NoteDiscovery";
    rev = "v${version}";
    hash = "sha256-ON1VMhKc5Yk4bGv1x1p4bPY91DH2KmmZnyu37A1n4Y8=";
  };

  notesDir = "/home/${config.settings.userLogin}/${config.settings.repos}/notes";
  runAsUser = config.settings.userLogin;
  port = 8005;

  configYaml = pkgs.writeText "notediscovery-config.yaml" ''
    app:
      name: "NoteDiscovery"
    server:
      host: "0.0.0.0"
      port: ${toString port}
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

  pythonEnv = pkgs.python3.withPackages (
    ps: with ps; [
      fastapi
      uvicorn
      python-multipart
      markdown
      pyyaml
      aiofiles
      cryptography
      bcrypt
      itsdangerous
      slowapi
      colorama
      pydantic
    ]
  );

  # Copie du repo, avec config.yaml remplacé et data/ transformé en lien
  # symbolique vers ton vrai dossier de notes.
  appDir = pkgs.runCommand "notediscovery-src-${version}" { } ''
    cp -r ${src} $out
    chmod -R u+w $out
    rm -f $out/config.yaml
    cp ${configYaml} $out/config.yaml
    rm -rf $out/data
    ln -s ${notesDir} $out/data
  '';
in
{
  environment.systemPackages = with pkgs; [
    hunspellDicts.fr-any
    aspellDicts.fr
  ];

  systemd.tmpfiles.rules = [
    "d ${notesDir} 0750 ${runAsUser} users - -"
  ];

  systemd.services.notediscovery = {
    description = "NoteDiscovery";
    wantedBy = [ "multi-user.target" ];
    after = [
      "network.target"
      "systemd-tmpfiles-setup.service"
    ];
    serviceConfig = {
      Type = "simple";
      User = runAsUser;
      WorkingDirectory = appDir;
      ExecStart = "${pythonEnv}/bin/uvicorn backend.main:app --host 0.0.0.0 --port ${toString port} --timeout-graceful-shutdown 2";
      Restart = "on-failure";
      RestartSec = 2;
    };
  };
}
