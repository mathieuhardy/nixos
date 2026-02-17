{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Git configuration
  # ────────────────────────────────────────────────────────────────────────────

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "${osConfig.settings.gitUserName}";
        email = "${osConfig.settings.gitUserEmail}";
      };

      core = {
        editor = "nvim";
      };
    };
  };
}
