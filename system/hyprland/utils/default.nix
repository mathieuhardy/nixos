{
  gitwatch,
  hyprmonitors,
  pkgs,
  pkgs-unstable,
  trash-monitor,
  waynote,
  ...
}:

{

  # ────────────────────────────────────────────────────────────────────────────
  # Imports
  # ────────────────────────────────────────────────────────────────────────────

  imports = [
    ./alt-f4
    ./battery-monitor
    ./diskard
    ./hyprlock
    ./toggle-bluetooth
    ./toggle-window
    ./workspace-navigation
  ];

  # ────────────────────────────────────────────────────────────────────────────
  # Packages
  # ────────────────────────────────────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    bluetui # TUI to manage bluetooth
    brightnessctl # Control of the brightness
    gitwatch.packages.${pkgs.stdenv.hostPlatform.system}.default
    hyprmonitors.packages.${pkgs.stdenv.hostPlatform.system}.default
    gsimplecal # GUI to show calendar
    impala # TUI wifi manager
    jq # Used in scripts to parse JSON outputs
    networkmanagerapplet # nm-applet (tray) + nm-connection-editor
    rofi # Power menu
    trash-monitor.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs-unstable.timr-tui # Countdown, timer, ...
    wayland-utils
    waynote.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
