{
  config,
  pkgs,
  ...
}:

{
  # ────────────────────────────────────────────────────────────────────────────
  # List of users
  # ────────────────────────────────────────────────────────────────────────────

  users.users."${config.settings.userLogin}" = {
    isNormalUser = true;
    description = "${config.settings.userName}";

    extraGroups = [
      "audio"
      "networkmanager"
      "video"
      "wheel"
    ];

    shell = pkgs.fish;
  };
}
