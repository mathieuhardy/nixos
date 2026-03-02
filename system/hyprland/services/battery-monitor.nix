{ pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # User service that watches the battery status to send notifications
  # ────────────────────────────────────────────────────────────────────────────

  systemd.user.services.battery-monitor = {
    description = "battery monitoring (for alerting)";

    wantedBy = [
      "graphical-session.target"
    ];

    after = [
      "graphical-session.target"
    ];

    partOf = [
      "graphical-session.target"
    ];

    serviceConfig = {
      Type = "exec";
      ExecStart = "${battery-monitor}/bin/battery-monitor";
      Restart = "always";
    };

    path = with pkgs; [
      libnotify
      coreutils
      bash
    ];
  };
}
