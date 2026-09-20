{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    clang
    gnumake
    protobuf
  ];
}
