{ lib, pkgs, config, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.loicdm = {
    isNormalUser = true;
    description = "Loïc Daudé Mondet";
    extraGroups =
      [ "networkmanager" "wheel" "libvirtd" "vboxusers" "jupyter" "rtkit" ];
    initialPassword = "password";
    shell = pkgs.zsh;
  };
}
