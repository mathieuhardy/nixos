{ pkgs, ... }:

{
  # ----------------------------------------------------------------------------
  # Fonts
  # ----------------------------------------------------------------------------

  fonts.fonts = with pkgs; [
    font-awesome-ttf
    material-design-icons
  ];
}
