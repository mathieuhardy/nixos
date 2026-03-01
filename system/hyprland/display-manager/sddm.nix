{ config, pkgs, ... }:

let
  # Thème SDDM Catppuccin — paquet nixpkgs
  sddm-catppuccin = pkgs.catppuccin-sddm.override {
    flavor = "frappe";
    font = "Commit Mono Nerd Font";
    fontSize = "14";
    # TODO:
    # background = "${config.users.users.${autologinUser}.home}/.local/share/backgrounds/sddm.jpg";
    loginBackground = true;
  };

  autologinUser = "mhardy"; # TODO:
in
{
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

        General = {
          GreeterEnvironment = "QT_WAYLAND_SHELL_INTEGRATION=layer-shell";
        };

        # Theme = {
        #   ThemeDir = "/run/current-system/sw/share/sddm/themes";
        #   CursorTheme = "Breeze";
        #   CursorSize = "24";
        # };
      };
    };
  };

  # TODO: move to a common section
  # environment.systemPackages = with pkgs; [
  #   catppuccin-sddm # thème Catppuccin pour SDDM
  #   kdePackages.breeze # curseur Breeze
  # ];

  # Expose le thème à SDDM
  services.displayManager.sddm.extraPackages = [ sddm-catppuccin ];
}
