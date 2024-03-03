{
  lib,
  pkgs,
  config,
  ...
}: {
  # Enable fwupd daemon (firmware updates)
  services.fwupd.enable = true;

  # Enable bluetooth support
  hardware.bluetooth.enable = true;

  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

}
