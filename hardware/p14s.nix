{
  # ../.
  boot.blacklistedKernelModules = lib.optionals (!config.hardware.enableRedistributableFirmware) [
    "ath3k"
  ];
  # ../.

  # ../../common/pc/laptop
  services.tlp.enable = lib.mkDefault (!config.services.power-profiles-daemon.enable);
  # ../../common/pc/laptop

  # ../.
  hardware.trackpoint.enable = lib.mkDefault true;
  hardware.trackpoint.emulateWheel = lib.mkDefault config.hardware.trackpoint.enable;

  # Fingerprint reader: login and unlock with fingerprint (if you add one with `fprintd-enroll`)
  # services.fprintd.enable = true;
  # ../.

  # ../../../common/pc/ssd
  services.fstrim.enable = lib.mkDefault true;
  # ../../../common/pc/ssd

  # ../.
  # Force use of the amdgpu driver for backlight control on kernel versions where the
  # native backlight driver is not already preferred. This is preferred over the
  # "vendor" setting, in this case the thinkpad_acpi driver.
  # See https://hansdegoede.livejournal.com/27130.html
  # See https://lore.kernel.org/linux-acpi/20221105145258.12700-1-hdegoede@redhat.com/
  boot.kernelParams = lib.mkIf (lib.versionOlder config.boot.kernelPackages.kernel.version "6.2") [
    "acpi_backlight=native"
  ];

  # see https://github.com/NixOS/nixpkgs/issues/69289
  boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "5.2") pkgs.linuxPackages_latest;
  # ../.

  # ../../../../common/cpu/amd
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # ../../../../common/cpu/amd

  # ../../../../common/gpu/amd
  config = {
    services.xserver.videoDrivers = lib.mkDefault [ "modesetting" ];

    hardware.graphics = {
      enable = lib.mkDefault true;
      enable32Bit = lib.mkDefault true;
    };

    hardware.amdgpu.initrd.enable = lib.mkDefault true;
  };
  # ../../../../common/gpu/amd

  # For support of newer AMD GPUs, backlight and internal microphone
  boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "5.8") pkgs.linuxPackages_latest;
}
