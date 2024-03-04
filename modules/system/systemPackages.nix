{
  lib,
  pkgs,
  config,
  ...
}: {

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    sudo
    wget
    efibootmgr
    
    libsmbios
    htop
    neofetch
    fastfetch
    helix
    git
    nvd
    # Development man pages
    man-pages
    man-pages-posix
    most
  ];
  programs.zsh.enable = true;


  # Development man pages
  documentation.dev.enable = true;

  # Mandoc as the default man page viewer
  documentation.man = {
  # In order to enable to mandoc man-db has to be disabled.
  man-db.enable = true;
  mandoc.enable = false;
  };

}
