_:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Auto-mount USB drives via udiskie
  # Tray disabled: visualization is handled by the custom waybar module
  # ────────────────────────────────────────────────────────────────────────────

  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "auto";
    settings = {
      program_config = {
        file_manager = "thunar";
      };
      # Ignore the encrypted data card (LUKS UUID of the container)
      device_config = [
        {
          id_uuid = "e7f34150-ee9b-45de-8dca-391761a45c6d";
          ignore = true;
        }
        {
          device_file = "/dev/sda";
          ignore = true;
        }
      ];
    };
  };
}
