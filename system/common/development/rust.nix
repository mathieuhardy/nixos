{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cargo
    cargo-llvm-cov
    cargo-nextest
    rust-analyzer
    rustup
  ];
}
