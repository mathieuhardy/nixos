{ config, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Login
  # ────────────────────────────────────────────────────────────────────────────

  services.displayManager = {
    sddm.enable = true;

    autoLogin = {
      enable = true;
      user = "${config.settings.userLogin}";
    };
  };
}
