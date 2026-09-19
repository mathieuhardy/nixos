{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Disable ALL display managers explicitly
  services.greetd.enable = lib.mkForce false;
  services.displayManager.sddm.enable = lib.mkForce false;
  services.xserver.displayManager.lightdm.enable = lib.mkForce false;
  services.xserver.displayManager.gdm.enable = lib.mkForce false;

  # Autologin on tty1
  services.getty.autologinUser = config.settings.userLogin;

  # Auto-start Hyprland on tty1
  environment.loginShellInit = ''
    if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec ${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop
    fi
  '';
}
