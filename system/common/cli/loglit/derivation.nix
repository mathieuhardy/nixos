{ pkgs, ... }:

pkgs.buildGoModule {
  pname = "loglit";
  version = "0.2.1";

  src = pkgs.fetchFromGitHub {
    owner = "madmaxieee";
    repo = "loglit";
    rev = "v0.2.1";
    hash = "sha256-MPYvBqiwDee3xDQHn4YOnZ7kSGSIsYvTo7dFdXP2sbk=";
  };

  vendorHash = "sha256-ixhruUAIHuG6vmLQ1TImgcgN/xVFiKMgHucD/8MJP/0=";
}
