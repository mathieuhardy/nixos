_:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Virtualisation configuration
  # ────────────────────────────────────────────────────────────────────────────

  virtualisation.containers = {
    enable = true;

    registries.search = [
      "docker.io"
    ];
  };
}
