{
  description = "A template that shows all standard flake outputs";

    inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };


  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware, ... }: {
    # Default overlay, for use in dependent flakes
    overlay = final: prev: { };




    # Used with `nixos-rebuild --flake .#<hostname>`
    # nixosConfigurations."<hostname>".config.system.build.toplevel must be a derivation

    nixosConfigurations.loicdm-pcp = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = inputs;
      modules = [
      ./configuration.nix
      ./modules/boot.nix
      ./modules/conf.nix
      ./modules/desktop.nix
      ./modules/fileSystems.nix
      ./modules/hardware/hardwareSupport.nix
      ./modules/localeAndTime.nix
      ./modules/networking.nix
      ./modules/nixpkgs.nix
      ./modules/systemPackages.nix
      ./modules/users/loicdm.nix
      ./modules/virtualisation.nix
      nixos-hardware.nixosModules.dell-xps-15-9560-intel

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
#           home-manager.nixosModules.home-manager
#           {
#             home-manager.useGlobalPkgs = true;
#             home-manager.useUserPackages = true;
#             home-manager.users.loicdm = import ./modules/home-manager/loicdm.nix;
#                # Configure nixpkgs.
#
#
#             # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
#           }
      ] ;
    };
  };
}
