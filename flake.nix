{
  description = "Loïc Daudé Mondet simple flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware, ... }: {
      # Default overlay, for use in dependent flakes
      overlay = final: prev: { };
      
      nixosConfigurations.loicdm-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          ./configuration.nix
          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.loicdm = { ... }: {
              imports = [
                ./home-manager/loicdm.nix
              ];
            };
          }
        ];
      };
    };
}
