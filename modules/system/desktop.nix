{
  lib,
  pkgs,
  config,
  ...
}: {
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Packages of gnome to exclude
  environment.gnome.excludePackages = with pkgs; [
    epiphany
    gnome.gnome-terminal
#    gnome.gedit
  ];

  environment.plasma6.excludePackages = with pkgs; [
  kdePackages.elisa
  ];

  programs.dconf.enable = true;
  services.xserver.displayManager.defaultSession = "plasma";


  # Disable gnome-terminal
  programs.gnome-terminal.enable = false;

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  environment.systemPackages = with pkgs; [
  kdePackages.sddm-kcm
  ];

  # qt.enable = true;
  # qt.style = "adwaita-dark";
  # qt.platformTheme = "gnome";

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;
  services.xserver.desktopManager.plasma6.enableQt5Integration = true;

  services.xserver.displayManager.sddm.wayland.enable = true;
  #services.xserver.displayManager.sddm.theme = "materia-dark" ;
  #services.xserver.displayManager.sddm.settings = {
  #General = {
  # background = "\"/mnt/cryptvault/Nextcloud/Ma bibliothèque/wallpapers/DSCF1290.JPG\"";
  #};
  #};
  xdg.portal.enable = true;

  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];
  xdg.portal.xdgOpenUsePortal = true;

  programs.firefox.enable = true;
  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "fr";
    xkb.variant = "";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  #services.jack.jackd.enable = true;
  #services.jack.loopback.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
    extraConfig.pipewire = {
      "10-clock-rate" = {
        "context.properties" = {
          "default.clock.rate" = 192000;
          "default.clock.allowed-rates" = [ 44100 48000 192000 ];
        };
      };
    };
  };
}