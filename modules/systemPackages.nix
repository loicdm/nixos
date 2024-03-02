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
    micro
    efibootmgr
    papirus-icon-theme

    gnome.adwaita-icon-theme
    libsmbios
    htop
    neofetch
    fastfetch
    helix
    git

    # Development man pages
    man-pages
    man-pages-posix
    most
  ];



  # Development man pages
  documentation.dev.enable = true;

  # Mandoc as the default man page viewer
  documentation.man = {
  # In order to enable to mandoc man-db has to be disabled.
  man-db.enable = true;
  mandoc.enable = false;
  };

}
