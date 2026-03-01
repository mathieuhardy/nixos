{
  config,
  pkgs,
  lib,
  ...
}:

{
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

      # --theme 'border=brightblack;text=white;prompt=blue;time=yellow;action=magenta' \

      initial_session = {
        command = "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop";
        user = "${config.settings.userLogin}";
      };

    };
  };
}
