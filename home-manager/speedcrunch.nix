{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Link to config:
  #   ~/.config/SpeedCrunch/SpeedCrunch.ini
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."SpeedCrunch".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/speedcrunch";
}
