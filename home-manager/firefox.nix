{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Dark theme
  # ────────────────────────────────────────────────────────────────────────────

  programs.firefox.profiles."default" = {
    settings = {
      "ui.systemUsesDarkTheme" = 1;
    };
  };
}
