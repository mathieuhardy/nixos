{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Link to config:
  #   ~/.claude/CLAUDE.md
  # ────────────────────────────────────────────────────────────────────────────

  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/claude/CLAUDE.md";
}
