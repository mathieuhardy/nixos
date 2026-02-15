{ pkgs, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Bootloader configuration
  # ────────────────────────────────────────────────────────────────────────────

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ────────────────────────────────────────────────────────────────────────────
  # Kernel version
  # ────────────────────────────────────────────────────────────────────────────

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
