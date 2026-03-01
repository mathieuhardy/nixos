{
  config,
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    tuigreet
  ];

  # Force NixOS à construire la dérivation desktops qui agrège les .desktop
  services.displayManager.sessionPackages = [ pkgs.hyprland ];

  services.greetd = {
    enable = true;
    restart = true;

    settings = {
      default_session = {
        command = ''
          ${pkgs.tuigreet}/bin/tuigreet \
            --time \
            --remember \
            --remember-user-session \
            --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions
        '';
        user = "greeter";
      };

      initial_session = {
        command = "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop";
        user = "mhardy";
      };

    };
  };

  # systemd.tmpfiles.rules = [
  #   "d /var/cache/tuigreet 0755 greeter greeter"
  # ];
  #
  # boot.kernelParams = [ "console=tty1" ];
}
