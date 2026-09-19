{
  config,
  lib,
  pkgs,
  ...
}:

{
  # ────────────────────────────────────────────────────────────────────────────
  # PostgreSQL database
  # ────────────────────────────────────────────────────────────────────────────

  services.postgresql = {
    enable = true;

    ensureUsers = [
      {
        name = "${config.settings.userLogin}";
        ensureClauses.superuser = true;
      }
    ];

    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host  all all 127.0.0.1/32 trust
      host  all all ::1/128      trust
    '';

    package = pkgs.postgresql_17;

    extensions =
      ps: with ps; [
        pg_uuidv7
      ];
  };

  # Don't start automatically. Use `sudo systemctl start postgresql`
  systemd.services.postgresql.wantedBy = lib.mkForce [ ];
}
