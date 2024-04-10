{ lib, pkgs, config, ... }: {
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/fdcbfc0c-472b-424b-ac33-f021f8084954";
    fsType = "btrfs";
    options = [ "subvol=nixos" ];
  };

  fileSystems."/efi" = {
    device = "/dev/disk/by-uuid/2EC5-C394";
    fsType = "vfat";
  };
  # Open the luks device and mount the filesystem
#   fileSystems."/cryptvault" = {
#     device = "/dev/mapper/luks-cryptvault";
#     label = "cryptvault";
#     fsType = "btrfs";
#     encrypted = {
#       enable = true;
#       label = "luks-cryptvault";
#       blkDev = "/dev/disk/by-uuid/1f6ffacd-9ec1-4e13-849f-de4b7cce913d";
#     };
#   };

  # Enable and configure zram swap
  zramSwap.enable = true;
}
