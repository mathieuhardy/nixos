_:

let
  ski = import ./derivation.nix {
    version = "0.7.0";
    sha256 = "sha256:1wxc7yd94f0kl66351xh0i972k229llvsn6mhkybzj12m1jakd8y";
  };
in
{
  imports = [ "${ski}/nix/module.nix" ];

  programs.ski.enable = true;
}
