# Auto-generated, do not edit !
{ config, ... }:

{
  boot = {
    supportedFilesystems = ["zfs"];

    initrd = {
      supportedFilesystems = ["zfs"];

      luks.devices."pool" = {
        device = "/dev/disk/by-partlabel/pool";
        keyFile = "/keyfile";
        allowDiscards = true;
        preLVM = true;
      };

      secrets = {
        "/keyfile" = "/etc/secrets/disks/keyfile";
      };
    };
  };
}
