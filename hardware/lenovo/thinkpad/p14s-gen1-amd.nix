_:

{
  # ────────────────────────────────────────────────────────────────────────────
  # SSD
  # ────────────────────────────────────────────────────────────────────────────

  services.fstrim.enable = true;

  # ────────────────────────────────────────────────────────────────────────────
  # Power management (disabled for now)
  # ────────────────────────────────────────────────────────────────────────────

  # services.tlp.enable = (!config.services.power-profiles-daemon.enable);

  # ────────────────────────────────────────────────────────────────────────────
  # Enable AMD driver with 3D acceleration and 32bits support
  # ────────────────────────────────────────────────────────────────────────────

  # TODO: set to amdgpu
  services.xserver.videoDrivers = [ "modesetting" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # To be enabled for plymooth for GPU acceleration
  # hardware.amdgpu.initrd.enable = true;

  # ────────────────────────────────────────────────────────────────────────────
  # Trackpoint (already working so disabled)
  # ────────────────────────────────────────────────────────────────────────────

  # hardware.trackpoint.enable = true;
  # hardware.trackpoint.emulateWheel = config.hardware.trackpoint.enable;

  # Fingerprint reader
  services.fprintd.enable = true;
}
