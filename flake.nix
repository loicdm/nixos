{
  description = "A template that shows all standard flake outputs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    #nixos-hardware.url = "github:NixOS/nixos-hardware/master";
#     nixvim = {
#       url = "github:nix-community/nixvim";
#       # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
#       # url = "github:nix-community/nixvim/nixos-23.05";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
    grub2-themes.url = "github:vinceliuice/grub2-themes";
    grub2-themes.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware
    , grub2-themes, ... }: {
      # Default overlay, for use in dependent flakes
      overlay = final: prev: { };

      # Used with `nixos-rebuild --flake .#<hostname>`
      # nixosConfigurations."<hostname>".config.system.build.toplevel must be a derivation

      nixosConfigurations.loicdm-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          ./configuration.nix
          ./modules/system/boot.nix
          ./modules/system/conf.nix
          #./modules/system/desktop/gnome.nix
          ./modules/system/desktop/plasma6.nix
          #./modules/system/desktop/plasma5.nix
          #./modules/system/desktop/hyprland.nix
          #./modules/system/desktop/waylandcomp.nix
          ./modules/system/fileSystems.nix
          ./modules/system/hardware/hardwareSupport.nix
          ./modules/system/hardware/nvidia.nix
	  ./modules/system/localeAndTime.nix
          ./modules/system/networking.nix
          ./modules/system/nixpkgs.nix
          ./modules/system/systemPackages.nix
          ./modules/system/users/loicdm.nix
          ./modules/system/users/root.nix
          ./modules/system/virtualisation.nix
          #./modules/system/k3s.nix
         # nixos-hardware.nixosModules.dell-xps-15-9560-intel
          grub2-themes.nixosModules.default

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.loicdm = { ... }: {
              imports = [
                ./modules/home-manager/users/loicdm.nix
                #nixvim.homeManagerModules.nixvim
              ];

            };
            home-manager.users.root = { ... }: {
              imports = [
                ./modules/home-manager/users/root.nix
                #nixvim.homeManagerModules.nixvim
              ];

            };
            # Configure nixpkgs.

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
    };
}
