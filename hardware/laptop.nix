# Laptop generic configuration

{ config, lib, pkgs, ... }:

{
  # Touchpad
  services.xserver.libinput = {
    enable = true;
    #tapping = false;
  };
}
