{ lib, pkgs, config, ... }: {
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.plasma6.excludePackages = with pkgs; [ kdePackages.elisa ];

  services.displayManager.defaultSession = "plasma";

  programs.ssh.startAgent = true;

  environment.systemPackages = with pkgs; [
    kdePackages.kate
    kdePackages.partitionmanager
    papirus-icon-theme
    gnome.adwaita-icon-theme
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    dracula-theme
    arc-theme
    arc-kde-theme
  ];

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    twitter-color-emoji
    symbola
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
  ];

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.wayland.compositor = "kwin";
  services.desktopManager.plasma6.enable = true;
  services.desktopManager.plasma6.enableQt5Integration = true;
  
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.xdgOpenUsePortal = true;

  programs.firefox.enable = false;
  
  # Configure keymap in X11
  services.xserver = {
    layout = "fr";
    xkbVariant = "";
  };

  environment.variables = {
    GTK_USE_PORTAL = "1";
  };


  # Enable CUPS to print documents.
  services.printing.enable = false;

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
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
}
