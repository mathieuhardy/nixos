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
  # initrd: use systemd to avoid race condition on LUKS prompt (NVMe not ready)
  # ────────────────────────────────────────────────────────────────────────────

  boot.initrd.systemd.enable = true;

  # ────────────────────────────────────────────────────────────────────────────
  # Enable AMD driver with 3D acceleration and 32bits support
  # ────────────────────────────────────────────────────────────────────────────

  boot.kernelModules = [ "amdgpu" ];

  services.xserver.videoDrivers = [ "amdgpu" ];

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
  #   > fprintd-enroll -f left-index-finger
  #   > fprintd-list $USER
  #   > fprintd-verify
  # services.fprintd.enable = true;
}
