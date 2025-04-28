{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nox.url = "github:madsbv/nix-options-search";
    nox.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nox, ... }:
  {
    # $ darwin-rebuild build --flake .#Murray
    darwinConfigurations.Murray = inputs.nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; system = "aarch64-darwin"; };
      modules = [
        ./configuration.nix
        inputs.home-manager.darwinModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };

            users.am_lazytude = import ./home.nix;
          };
        }
      ];
    };
  };
}
