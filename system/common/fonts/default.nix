{ pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Fonts
  # ────────────────────────────────────────────────────────────────────────────

  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      nerd-fonts.commit-mono
      source-code-pro
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "DejaVu Sans Mono" ];
      };
    };
  };
}
