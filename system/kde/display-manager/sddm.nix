{ config, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # SDDM with auto login
  # ────────────────────────────────────────────────────────────────────────────

  services.displayManager = {
    sddm.enable = true;

    autoLogin = {
      enable = true;
      user = "${config.settings.userLogin}";
    };
  };
}
