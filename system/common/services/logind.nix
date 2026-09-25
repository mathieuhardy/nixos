_:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Don't handle Lid when docker
  # ────────────────────────────────────────────────────────────────────────────

  services.logind.settings.Login = {
    HandleLidSwitchDocked = "ignore";
  };
}
