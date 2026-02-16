{ ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # SSH config
  # ────────────────────────────────────────────────────────────────────────────

  programs.ssh = {
    enable = true;

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
