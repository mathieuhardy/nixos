{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dbeaver-bin
    sqlx-cli
  ];
}
