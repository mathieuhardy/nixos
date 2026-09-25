{ pkgs, ... }:

pkgs.buildGoModule {
  pname = "loglit";
  version = "unstable-2025-02-15";

  src = pkgs.fetchFromGitHub {
    owner = "madmaxieee";
    repo = "loglit";
    rev = "4bcfb21838283343a460a316e183c70d6a31886a";
    hash = "sha256-y9n6wtlwpujoANUjXkF5aCl1ZwJjxE4T1JmeqtyuLc0=";
  };

  vendorHash = "sha256-ixhruUAIHuG6vmLQ1TImgcgN/xVFiKMgHucD/8MJP/0=";
}
