{ lib, pkgs, config, ... }: {
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/bd66b9a2-50c2-4051-9c14-beea2d123a7b";
    fsType = "btrfs";
    options = [ "subvol=nixos" ];
  };

  fileSystems."/efi" = {
    device = "/dev/disk/by-uuid/F98C-1800";
    fsType = "vfat";
  };
  # Open the luks device and mount the filesystem
  fileSystems."/cryptvault" = {
    device = "/dev/mapper/luks-cryptvault";
    label = "cryptvault";
    fsType = "btrfs";
    encrypted = {
      enable = true;
      label = "luks-cryptvault";
      blkDev = "/dev/disk/by-uuid/1f6ffacd-9ec1-4e13-849f-de4b7cce913d";
    };
  };

  # Enable and configure zram swap
  zramSwap.enable = true;
}
