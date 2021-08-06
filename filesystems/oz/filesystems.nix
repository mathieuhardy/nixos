# Auto-generated, do not edit !
{ config, ... }:

{
  networking.hostId = "003e0583";

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-partlabel/uefi";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "pool/root";
    fsType = "zfs";
  };
}
