{ pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Apply config at startup
  # ────────────────────────────────────────────────────────────────────────────

  systemd.user.services.input-remapper-autoload = {
    description = "input-remapper autoload";
    wantedBy = [ "graphical-session.target" ];
    after = [
      "graphical-session.target"
      "input-remapper.service"
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.input-remapper}/bin/input-remapper-control --command autoload";
    };
  };
}
