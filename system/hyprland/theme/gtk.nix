{ pkgs, ... }:

let
  # Override color of the catppuccin-gtk pakage
  catppuccin-gtk = pkgs.catppuccin-gtk.override {
    accents = [ "mauve" ];
    variant = "frappe";
  };
in
{
  environment.systemPackages = with pkgs; [
    # GTK theme
    catppuccin-gtk
  ];
}
