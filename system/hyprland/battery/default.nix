{ pkgs, ... }:

let
  battery-monitor = pkgs.writeShellScriptBin "battery-monitor" (
    builtins.readFile ./scripts/battery-monitor.sh
  );
in
{
  # ────────────────────────────────────────────────────────────────────────────
  # Service that watches the battery level and send notifications.
  # ────────────────────────────────────────────────────────────────────────────

  environment.systemPackages = [ battery-monitor ];

  systemd.user.services.battery-monitor = {
    description = "battery monitoring (for alerting)";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "exec";
      ExecStart = "${battery-monitor}/bin/battery-monitor";
    };
  };
}
