{
  config,
  osConfig,
  pkgs,
  ...
}:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Hyrpidle in user space to be able to access DBUS and other stuff
  # ────────────────────────────────────────────────────────────────────────────

  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "${pkgs.hyprlock}/bin/hyprlock";
        before_sleep_cmd = "${pkgs.hyprlock}/bin/hyprlock";
        after_sleep_cmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      };

      listener = [
        # 1 min → dim
        {
          timeout = 60;
          on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10%";
          on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r";
        }

        # 2 min → lock
        {
          timeout = 120;
          on-timeout = "${pkgs.hyprlock}/bin/hyprlock";
        }

        # 10 min → suspend
        {
          timeout = 600;
          on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };
  };
}
