{ pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Fonts
  # ────────────────────────────────────────────────────────────────────────────

  fonts.packages = with pkgs; [
    dejavu_fonts
    nerd-fonts.commit-mono
    source-code-pro

    # TODO: Wayland temporary config
    # nerd-fonts.jetbrains-mono
    # nerd-fonts.fira-code
    # nerd-fonts.symbols-only
    # noto-fonts
    # noto-fonts-emoji
  ];
}
