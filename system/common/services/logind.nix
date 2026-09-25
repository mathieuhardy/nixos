_:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Don't handle Lid when docker
  # ────────────────────────────────────────────────────────────────────────────

  services.logind.extraConfig = ''
    HandleLidSwitchDocked=ignore
  '';
}
