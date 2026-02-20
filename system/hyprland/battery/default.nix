{ pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Service that watches the battery level and send notifications.
  # ────────────────────────────────────────────────────────────────────────────

  systemd.user.services.battery-alert = {
    description = "battery alerting";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "exec";
      ExecStart = "${pkgs.bash}/bin/bash %h/.config/hypr/scripts/battery-alert.sh";
    };
  };
}
