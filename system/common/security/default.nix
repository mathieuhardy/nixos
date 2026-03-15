_:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Security
  # ────────────────────────────────────────────────────────────────────────────

  security = {
    # Disable password for sudo commands for users in group `wheel`
    sudo.wheelNeedsPassword = false;

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
