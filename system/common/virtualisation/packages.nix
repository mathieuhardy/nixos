{ pkgs, ... }:

{
  # TODO: remove ASAP
  nixpkgs.config.permittedInsecurePackages = [
    "docker-28.5.2"
  ];

  environment.systemPackages = with pkgs; [
    docker
    oxker # Docker TUI
  ];
}
