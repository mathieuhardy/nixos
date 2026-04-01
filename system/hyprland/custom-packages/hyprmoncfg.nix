{ pkgs-unstable, ... }:

(pkgs-unstable.buildGoModule.override { go = pkgs-unstable.go_1_26; }) {
  pname = "hyprmoncfg";
  version = "1.0.3";

  src = pkgs-unstable.fetchFromGitHub {
    owner = "crmne";
    repo = "hyprmoncfg";
    rev = "v1.0.3";
    hash = "sha256-LQqBLP6lSgMyFs6tdp8qvfJF895Xq3aAFQ98BjaExzI=";
  };

  vendorHash = "sha256-ME0hsa+HRzYwx7y/nRmbzVHbq26aEfcKpc804FnCQC8=";

  subPackages = [
    "cmd/hyprmoncfg"
    "cmd/hyprmoncfgd"
  ];

  postPatch = ''
    sed -i 's/^go 1\.26\.1/go 1.26.0/' go.mod
  '';

  meta = {
    description = "TUI monitor configuration tool for Hyprland";
    homepage = "https://hyprmoncfg.dev";
    license = pkgs-unstable.lib.licenses.mit;
    mainProgram = "hyprmoncfg";
  };
}
