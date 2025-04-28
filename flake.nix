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
    let
      mkMacSystem = import ./lib/mkMacSystem.nix {
        inherit inputs;
      };
    in
    {
      # $ darwin-rebuild build --flake .#Murray
      darwinConfigurations.Max = mkMacSystem {
        system = "aarch64-darwin";
        systemConfig = systems/max.nix;
      };

      darwinConfigurations.Murray = mkMacSystem {
        system = "aarch64-darwin";
        systemConfig = systems/murray.nix;
      };
    };
}
