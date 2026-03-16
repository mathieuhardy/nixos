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
          env XKB_DEFAULT_LAYOUT=fr \
          ${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.regreet}/bin/regreet
        '';
        user = "greeter";
      };

      initial_session = {
        command = "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop";
        user = "${config.settings.userLogin}";
      };
    };
  };

  environment.etc."greetd/wayland-sessions/uwsm.desktop".source =
    "${config.programs.uwsm.package}/share/wayland-sessions/uwsm.desktop";

  environment.etc."greetd/regreet.toml".text = ''
    [GTK]
    application_prefer_dark_theme = true
    sessions_path = "/etc/greetd/wayland-sessions"
  '';
  # sessions_path = "${config.services.displayManager.sessionData.desktops}/share/wayland-sessions"
}
