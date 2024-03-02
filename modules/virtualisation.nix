{
  lib,
  pkgs,
  config,
  ...
}: {
  # Enable libvirtd service (virtualisation)
  virtualisation.libvirtd.enable = true;
  # Disable start of all vms on boot
  virtualisation.libvirtd.onBoot = "ignore";
  # Run libvirtd daemon as qemu-libvirtd instaed of root user
  virtualisation.libvirtd.qemu.runAsRoot = false;
  # Required for virt-manager
  programs.dconf.enable = true;

  # Enable VirtualBox.
  # In order to pass USB devices from the host to the guests,
  # the user needs to be in the vboxusers group.
  # virtualisation.virtualbox.host.enable = true;

  # Install the Oracle Extension Pack for VirtualBox.
  # You must set nixpkgs.config.allowUnfree = true in order to use this.
  # This requires you accept the VirtualBox PUEL.
  # virtualisation.virtualbox.host.enableExtensionPack = true;
}
