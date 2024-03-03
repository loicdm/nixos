{
  lib,
  pkgs,
  config,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}

