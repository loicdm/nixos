{
  description = "NixOS config – loicdm-pc";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";

      mkSystem =
        hostname:
        nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            # Base config
            ./configuration.nix

            # Allow unfree packages
            { nixpkgs.config.allowUnfree = true; }

            # Set hostname
            { networking.hostName = hostname; }

            # Home Manager
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                users = {
                  loicdm = import ./home/loicdm.nix;
                  sasha = import ./home/sasha.nix;
                  root = import ./home/root.nix;
                };
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        loicdm-pc = mkSystem "loicdm-pc";
      };
    };
}
