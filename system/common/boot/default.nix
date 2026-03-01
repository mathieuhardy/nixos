{ pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Bootloader configuration
  # ────────────────────────────────────────────────────────────────────────────

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 2;

  # ────────────────────────────────────────────────────────────────────────────
  # Kernel configuration
  # ────────────────────────────────────────────────────────────────────────────

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "console=tty1" ];
}
