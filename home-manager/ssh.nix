{ ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # SSH config
  # ────────────────────────────────────────────────────────────────────────────

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_ed25519";
        extraOptions = {
          PreferredAuthentications = "publickey";
        };
      };
    };
  };
}
