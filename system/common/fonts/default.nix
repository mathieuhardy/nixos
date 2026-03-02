{ pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Fonts
  # ────────────────────────────────────────────────────────────────────────────

  fonts = {
    packages = with pkgs; [
      inter # For GUI
      nerd-fonts.commit-mono # For development
      noto-fonts # For the rest
      noto-fonts-color-emoji
    ];

    fontconfig = {
      enable = true;

      defaultFonts = {
        monospace = [
          "CommitMono Nerd Font"
        ];

        sansSerif = [
          "Noto Sans"
          "Inter"
        ];

        serif = [
          "Noto Serif"
        ];

        emoji = [
          "Noto Color Emoji"
        ];
      };
    };
  };
}
