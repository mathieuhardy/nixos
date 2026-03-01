{ pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Greetd with auto login
  # ────────────────────────────────────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    cage
    # greetd
    # regreet
  ];

  # Activer greetd via un service systemd
  # systemd.user.services.greetd = {
  #   description = "Greetd Display Manager";
  #   wantedBy = [ "graphical.target" ];
  #   serviceConfig = {
  #     ExecStart = "${pkgs.greetd}/bin/greetd -debug";
  #     Restart = "always";
  #     User = "mhardy";
  #   };
  # };

  services.greetd = {
    enable = true;
    restart = true;

    settings = {
      default_session = {
        command = "${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.regreet}/bin/regreet";
        user = "greeter";
      };

      # default_session = {
      #   command = "${pkgs.greetd.regreet}/bin/regreet";
      #   user = "greeter";
      # };

      # Auto-login
      initial_session = {
        command = "${pkgs.uwsm}/bin/uwsm start hyprland";
        user = "mhardy";
      };
    };
  };

  # users.users.greeter = {
  #   isSystemUser = true;
  #   group = "greeter";
  # };
  # users.groups.greeter = { };

  programs.regreet = {
    enable = true;
    settings = {
      default_session = {
        user = "mhardy"; # pré-rempli dans l'UI de regreet
      };
    };
  };
}
