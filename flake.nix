{
  description = "NixOS config – loicdm-pc";

  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs =
    { self, nixpkgs, ... }:
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
        ];
      };
    };
}
