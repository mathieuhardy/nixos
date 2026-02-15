{ config, pkgs, ... }:

{
  users.users.mhardy = {
    isNormalUser = true;
    description = "Mathieu Hardy";
    extraGroups = [
      "audio"
      "networkmanager"
      "video"
      "wheel"
    ];
    shell = pkgs.fish;

    # TODO: move
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
}
