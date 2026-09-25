{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    starship
  ];

  programs = {
    bash.enable = true;
    fish.enable = true;
  };
}
