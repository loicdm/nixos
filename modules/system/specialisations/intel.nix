{
  lib,
  pkgs,
  config,
  nixos-hardware,
  ...
}: {
  specialisation = {
    intel.configuration = {...}: {
      imports = [
        nixos-hardware.nixosModules.dell-xps-15-9560-intel
        #"${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/dell/xps/15-9560/nvidia"
      ];
      disabledModules = [
      ];
      system.nixos.tags = ["intel"];

      programs.gamemode.enable = true;

      # Enable OpenGL
      hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
    };
  };
}
