# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./modules/hardware-configuration.nix
      ./modules/plasma6.nix
      ./modules/localeAndTime.nix
      ./modules/boot.nix
      ./modules/fileSystems.nix
      ./modules/networking.nix
    ];
    
  # Define system name
  system.name = "loicdm-pc";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.loicdm = {
    isNormalUser = true;
    description = "Loïc Daudé Mondet";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Enable flakes permanently in NixOS
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Auto optimize nix store
  nix.settings.auto-optimise-store = true;
  
  # Auto update the system
  system.autoUpgrade.enable = false;
  system.autoUpgrade.allowReboot = false;

  security.sudo.extraConfig = "Defaults pwfeedback";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  	git
  	eza
  	efibootmgr
  	neovim
  	htop
  	fastfetch
  ];
  
  programs.zsh.enable = true;

  # Development man pages
  documentation.dev.enable = true;
  documentation.man = {
    # In order to enable to mandoc man-db has to be disabled.
    man-db.enable = true;
    mandoc.enable = false;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
