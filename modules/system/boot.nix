{ lib, pkgs, config, ... }: {
  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.grub.useOSProber = false;
  boot.loader.timeout = null;
  # boot.loader.grub.default = 1;
  #  boot.loader.grub.extraGrubInstallArgs = [
  # "--modules=nativedisk btrfs ahci pata part_gpt part_msdos diskfilter mdraid1x lvm ext2"
  #];

  boot.loader.grub2-theme = {
    enable = true;
    theme = "stylish";
    footer = true;
  };

  # Enable plymouth (boot splash screen)
  #boot.plymouth.enable = true;

  #  ! Experimental ! enable systemd in initrd
  # required to be able to enter crypt device passphrase with plymouth
  boot.initrd.systemd.enable = true;
  boot.initrd.verbose = false;

  # Silent boot
  boot.consoleLogLevel = 0;
  boot.kernelParams = [ "quiet" "udev.log_level=3" ];
  boot.initrd.availableKernelModules =
    [ "xhci_pci" "nvme" "usbhid" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Enable ntfs support
  # boot.supportedFilesystems = ["ntfs"];

  boot.kernelPackages = pkgs.linuxPackages_zen;
}
