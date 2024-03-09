{ lib, pkgs, config, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.root = {
    isSystemUser = true;
    description = lib.mkForce "Loïc Daudé Mondet";
    initialPassword = "password";
    shell = pkgs.zsh;
  };
}
