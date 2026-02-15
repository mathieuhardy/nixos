{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Git configuration
  # ────────────────────────────────────────────────────────────────────────────

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Mathieu Hardy";
        email = "mhardy2008@gmail.com";
      };

      core = {
        editor = "nvim";
      };
    };
  };
}
