{
  hyprmonitors,
  pkgs,
  pkgs-unstable,
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
    ./gitwatch
    ./hyprlock
    ./network-manager-sidebar
    ./toggle-bluetooth
    ./toggle-window
    ./trash-monitor
    ./workspace-navigation
  ];

  # ────────────────────────────────────────────────────────────────────────────
  # Packages
  # ────────────────────────────────────────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    bluetui # TUI to manage bluetooth
    brightnessctl # Control of the brightness
    hyprmonitors.packages.${pkgs.stdenv.hostPlatform.system}.default
    gsimplecal # GUI to show calendar
    jq # Used in scripts to parse JSON outputs
    networkmanagerapplet # nm-applet (tray) + nm-connection-editor
    rofi # Power menu
    pkgs-unstable.timr-tui # Countdown, timer, ...
    wayland-utils
    waynote.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
