{
  description = "NixOS configuration";

  # ────────────────────────────────────────────────────────────────────────────
  # Inputs
  # ────────────────────────────────────────────────────────────────────────────

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprmonitors = {
      url = "github:mathieuhardy/hyprmonitors";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    koob = {
      url = "github:mathieuhardy/koob";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # ────────────────────────────────────────────────────────────────────────────
  # Outputs
  # ────────────────────────────────────────────────────────────────────────────

  outputs =
    {
      home-manager,
      hyprmonitors,
      koob,
      nixpkgs,
      nixpkgs-unstable,
      sops-nix,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable { inherit system; };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = { inherit hyprmonitors koob pkgs-unstable; };

        modules = [
          # Settings
          ./common/settings.nix

          # System entry point
          ./main.nix

          # Home manager
          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }

          (
            { config, ... }:
            {
              home-manager.users."${config.settings.userLogin}" = {
                imports = [
                  # SOPS must be declared before home-manager
                  sops-nix.homeManagerModules.sops

                  # Home manager entry point
                  ./home-manager/default.nix
                ];
              };
            }
          )
        ];
      };
    };
}
