{
  description = "NixOS configuration";

  # ────────────────────────────────────────────────────────────────────────────
  # Inputs
  # ────────────────────────────────────────────────────────────────────────────

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # ────────────────────────────────────────────────────────────────────────────
  # Outputs
  # ────────────────────────────────────────────────────────────────────────────

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      sops-nix,
      ...
    }:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Settings
          ./common/settings.nix

          # Entry point
          ./main.nix

          # Home manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mhardy = {
              imports = [
                # SOPS must be declared before home-manager
                sops-nix.homeManagerModules.sops

                ./home-manager/default.nix
              ];
            };
          }
        ];
      };
    };
}
