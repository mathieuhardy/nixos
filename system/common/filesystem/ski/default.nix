_:

let
  ski = import ./derivation.nix {
    version = "0.6.4";
    sha256 = "1lj9sgi2rpcr6h9brnznkcf9bdc1mf8640kzz5iqs8wq4m1v672g";
  };
in
{
  imports = [ "${ski}/nix/module.nix" ];

  programs.ski.enable = true;
}
