{ lib, pkgs, config, ... }: {
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/b3804b77-ce8b-48d4-b475-61247cb1513f";
    fsType = "btrfs";
  };

  fileSystems."/efi" = {
    device = "/dev/disk/by-uuid/2EC5-C394";
    fsType = "vfat";
  };
  
  fileSystems."/cloud" = {
    device = "/dev/disk/by-uuid/dd7b7ed3-431f-4945-872b-2c784fb96207";
    fsType = "btrfs";
    options = [ "subvol=cloud2" ];
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
