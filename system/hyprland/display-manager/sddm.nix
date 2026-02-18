{ config, pkgs, ... }:

let
  # Thème SDDM Catppuccin — paquet nixpkgs
  sddm-catppuccin = pkgs.catppuccin-sddm.override {
    flavor = "mocha";
    font = "JetBrains Mono Nerd Font";
    fontSize = "14";
    # background = "${config.users.users.${autologinUser}.home}/.local/share/backgrounds/sddm.jpg";
    loginBackground = true;
  };

  autologinUser = "mhardy"; # TODO
in
{
  # ────────────────────────────────────────────────────────────────────────────
  # SDDM with auto login
  # ────────────────────────────────────────────────────────────────────────────

  services.displayManager = {
    sddm = {
      enable = true;

      wayland.enable = true;

      settings = {
        Autologin = {
          User = "${config.settings.userLogin}";
          Session = "hyprland"; # fichier .desktop dans /share/wayland-sessions/
          Relogin = false; # ne pas re-autologin après logout manuel
        };

        General = {
          GreeterEnvironment = "QT_WAYLAND_SHELL_INTEGRATION=layer-shell";
        };

        Theme = {
          ThemeDir = "/run/current-system/sw/share/sddm/themes";
          CursorTheme = "Breeze";
          CursorSize = "24";
        };
      };
    };
  };

  # TODO: move to a common section
  environment.systemPackages = with pkgs; [
    catppuccin-sddm # thème Catppuccin pour SDDM
    kdePackages.breeze # curseur Breeze
  ];

  # Expose le thème à SDDM
  services.displayManager.sddm.extraPackages = [ sddm-catppuccin ];
}
