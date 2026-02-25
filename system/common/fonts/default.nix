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
          "Noto Color Emoji"
        ];

        sansSerif = [
          "Inter"
          "Noto Color Emoji"
        ];

        serif = [
          "Noto Serif"
          "Noto Color Emoji"
        ];

        emoji = [
          "Noto Color Emoji"
        ];
      };
    };
  };
}
