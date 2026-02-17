{ config, pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Decrypt secrets with SOPS and install them
  #   - Mistral API key
  #   - GitHub SSH keys
  # ────────────────────────────────────────────────────────────────────────────

  sops = {
    defaultSopsFile = ./secrets.toml;
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  };

  sops.secrets."mistral/api_key.txt" = {
    sopsFile = ./secrets/mistral/api_key.json;
    path = "${config.home.homeDirectory}/.config/mistral/api_key.txt";
    mode = "0644";
  };

  sops.secrets."ssh/id_ed25519" = {
    sopsFile = ./secrets/ssh/id_ed25519.json;
    path = "${config.home.homeDirectory}/.ssh/id_ed25519";
    mode = "0600";
  };

  sops.secrets."ssh/id_ed25519_pub" = {
    sopsFile = ./secrets/ssh/id_ed25519_pub.json;
    path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
    mode = "0644";
  };
}
