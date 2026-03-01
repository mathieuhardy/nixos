{ pkgs, ... }:

{
  systemd.user.services.wpaperd = {
    description = "wpaperd wallpaper daemon";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.wpaperd}/bin/wpaperd";
      Restart = "on-failure";
    };
  };
}
