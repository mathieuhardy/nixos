# Auto-generated, do not edit !
{ config, ... }:

{
  boot.loader = {
    timeout = 1;

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };

    grub = {
      enable = true;
      device = "nodev";
      version = 2;
      efiSupport = true;
      enableCryptodisk = true;
      copyKernels = true;
      zfsSupport = true;
    };
  };
}
