{ pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Fonts
  # ────────────────────────────────────────────────────────────────────────────

  fonts = {
    packages = with pkgs; [
      nerd-fonts.commit-mono
      noto-fonts
      noto-fonts-cjk
      noto-fonts-color-emoji
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "CommitMono Nerd Font" ];
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
