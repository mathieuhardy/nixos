{
  pkgs,
  pkgs-unstable,
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
    ./gitwatch
    ./hyprlock
    ./hyprmonitors
    ./network-manager-sidebar
    ./toggle-bluetooth
    ./toggle-window
    ./trash-monitor
    ./waynote
    ./workspace-navigation
  ];

  # ────────────────────────────────────────────────────────────────────────────
  # Packages
  # ────────────────────────────────────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    bluetui # TUI to manage bluetooth
    brightnessctl # Control of the brightness
    gsimplecal # GUI to show calendar
    jq # Used in scripts to parse JSON outputs
    networkmanagerapplet # nm-applet (tray) + nm-connection-editor
    rofi # Power menu
    pkgs-unstable.timr-tui # Countdown, timer, ...
    wayland-utils
  ];
}
