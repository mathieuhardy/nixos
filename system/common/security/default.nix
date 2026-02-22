{ ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Security
  # ────────────────────────────────────────────────────────────────────────────

  # Disable password for sudo commands for users in group `wheel`
  security.sudo.wheelNeedsPassword = false;

  # RealtimeKit system service
  security.rtkit.enable = true;

  # Polkit
  security.polkit.enable = true;

  # ────────────────────────────────────────────────────────────────────────────
  # Custom rules
  # ────────────────────────────────────────────────────────────────────────────

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';
}
