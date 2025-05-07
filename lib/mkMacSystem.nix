{ inputs }: { system, systemConfig }:

inputs.nix-darwin.lib.darwinSystem {
  modules = systemConfig ++ [
    inputs.home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        users.am_lazytude = import ../home.nix;
      };
    }
  ];
  specialArgs = { inherit inputs system; };
}
