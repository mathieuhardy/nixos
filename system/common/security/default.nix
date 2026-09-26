_:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Imports
  # ────────────────────────────────────────────────────────────────────────────

  imports = [
    ./packages.nix
  ];

  # ────────────────────────────────────────────────────────────────────────────
  # Security
  # ────────────────────────────────────────────────────────────────────────────

  security = {
    # Disable password for sudo commands for users in group `wheel`
    sudo.wheelNeedsPassword = false;

    # Preserve Wayland env vars when using sudo (needed for GUI apps like gparted)
    sudo.extraConfig = ''
      Defaults env_keep += "WAYLAND_DISPLAY XDG_RUNTIME_DIR DISPLAY GDK_BACKEND"
    '';

    # RealtimeKit system service
    rtkit.enable = true;

    # Polkit
    polkit = {
      enable = true;

      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (subject.isInGroup("wheel")) {
            return polkit.Result.YES;
          }
        });
      '';
    };
  };

}
