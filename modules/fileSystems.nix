{ lib, pkgs, config, ... }: {
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/9b28987b-243d-4477-af59-d3ace2efa906";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/2EC5-C394";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/cloud" =
    { device = "/dev/disk/by-uuid/dd7b7ed3-431f-4945-872b-2c784fb96207";
      fsType = "btrfs";
    };

  swapDevices = [ ];

  # Enable and configure zram swap
  zramSwap.enable = true;
}
