{ ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Hyrpidle in user space to be able to access DBUS and other stuff
  # ────────────────────────────────────────────────────────────────────────────

  services.hypridle = {
    enable = true;
  };
}
