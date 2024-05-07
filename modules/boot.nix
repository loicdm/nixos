{ lib, pkgs, config, ... }: {

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.gfxmodeEfi = lib.mkDefault "1920x1200";
  boot.loader.grub.gfxpayloadEfi = "keep";
  boot.loader.timeout = null;

  # Initrd Options
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  # Kernel Options
  boot.kernelModules = [ "kvm-intel" ];
  
  boot.extraModulePackages = [ ];
  
  # Change Kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;
}
