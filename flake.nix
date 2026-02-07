{
  description = "NixOS config – loicdm-pc";

  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.loicdm-pc = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          # Autorise les paquets non-free
          { nixpkgs.config.allowUnfree = true; }

          ./configuration.nix

          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.loicdm = import ./home/loicdm.nix;
          }
        ];
      };
    };
}
