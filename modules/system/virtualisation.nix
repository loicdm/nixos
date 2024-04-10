{ lib, pkgs, config, ... }: {
  # Run libvirtd daemon as qemu-libvirtd instaed of root user


  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMFFull.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };

  # Required for virt-manager
  programs.virt-manager.enable = true;

  # nested virtualisation support 
  boot.extraModprobeConfig = "options kvm_intel nested=1";

  #virtualisation.docker.enable = true;
  #virtualisation.docker.storageDriver = "btrfs";

  # Enable VirtualBox.
  # In order to pass USB devices from the host to the guests,
  # the user needs to be in the vboxusers group.
  # virtualisation.virtualbox.host.enable = true;

  # Install the Oracle Extension Pack for VirtualBox.
  # You must set nixpkgs.config.allowUnfree = true in order to use this.
  # This requires you accept the VirtualBox PUEL.
  # virtualisation.virtualbox.host.enableExtensionPack = true;
}
