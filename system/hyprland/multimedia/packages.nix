{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    feh # Image viewer
    hyprshot # Screenshots
    hyprpicker # Color picker
    playerctl # GUI to control media
    pwvucontrol # GUI to control volume
    swayimg # Image viewer
  ];
}
