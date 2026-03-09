{ pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # User service that sets the wallpaper on monitors
  # ────────────────────────────────────────────────────────────────────────────

  systemd.user.services.wpaperd = {
    description = "wpaperd wallpaper daemon";

    wantedBy = [ "graphical-session.target" ];

    after = [
      "graphical-session.target"
    ];

    partOf = [
      "graphical-session.target"
    ];

    serviceConfig = {
      Type = "exec";
      ExecStart = "${pkgs.wpaperd}/bin/wpaperd";
      Restart = "on-failure";
      RestartSec = 1;

      Environment = [
        "XDG_SESSION_TYPE=wayland"
      ];
    };
  };
}
