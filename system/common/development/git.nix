{ pkgs, ... }:

let
  git-branch-checker = pkgs.callPackage ../custom-packages/git-branch-checker.nix { };
in
{
  environment.systemPackages = with pkgs; [
    git-branch-checker # Checks if local branches are merged
    gitg
  ];
}
