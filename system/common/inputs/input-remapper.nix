{ pkgs, lib, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Apply config at startup
  # ────────────────────────────────────────────────────────────────────────────

  services.input-remapper.enable = true;

  # Delay daemon start until graphical session
  systemd.services.input-remapper.wantedBy = lib.mkForce [ "graphical.target" ];

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
