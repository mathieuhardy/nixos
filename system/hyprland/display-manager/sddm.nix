{ config, pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Packages
  # ────────────────────────────────────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    (catppuccin-sddm.override {
      flavor = "frappe";
      # optionnel :
      # font = "Noto Sans";
      # fontSize = "9";
      # background = "${./wallpaper.png}";
      # loginBackground = true;
    })
  ];

  # ────────────────────────────────────────────────────────────────────────────
  # SDDM with auto login
  # ────────────────────────────────────────────────────────────────────────────

  services.displayManager = {
    # Default session to be selected for login
    defaultSession = "hyprland-uwsm";

    sddm = {
      enable = true;

      # Needed at least by hyprland that runs on wayland
      wayland.enable = true;

      theme = "catppuccin-frappe";

      settings = {
        Autologin = {
          User = "${config.settings.userLogin}";
          Session = "hyprland-uwsm";
          Relogin = false;
        };

        # General = {
        #   GreeterEnvironment = "QT_WAYLAND_SHELL_INTEGRATION=layer-shell";
        # };

        # Theme = {
        #   ThemeDir = "/run/current-system/sw/share/sddm/themes";
        #   CursorTheme = "Breeze";
        #   CursorSize = "24";
        # };
      };
    };
  };
}
