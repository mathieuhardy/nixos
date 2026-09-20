{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    age # For secrets encryption in NixOS configuration
    sops # For secrets encryption in NixOS configuration
    steghide # for tomb exhume
    tomb
  ];
}
