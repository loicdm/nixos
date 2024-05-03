{ lib, pkgs, config, ... }: {
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.plasma6.excludePackages = with pkgs; [ kdePackages.elisa ];

  programs.dconf.enable = true;
  services.displayManager.defaultSession = "plasma";

  programs.ssh.startAgent = true;

  # Disable gnome-terminal
  # programs.gnome-terminal.enable = false;

  # services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  environment.systemPackages = with pkgs; [
    kdePackages.sddm-kcm
    keepassxc
    nextcloud-client
    #discord
    armcord
    #neovim
    kdePackages.kate
    wl-clipboard
    wireguard-tools
    git
    # python3
    hunspellDicts.fr-any
    libreoffice-qt
    #      nerdfonts
    zoom-us
    vlc
    btop
    # prismlauncher-qt5
    # (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    kdePackages.partitionmanager
    eza
    papirus-icon-theme
    #     adwaita-qt
    #     qadwaitadecorations
    gnome.adwaita-icon-theme
    #     materia-theme
    #     materia-kde-theme
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    dracula-theme
    #kdePackages.ki18n
    #libsForQt5.ki18n
    #kdePackages.qttranslations
    #libsForQt5.qt5.qttranslations
    ((where-is-my-sddm-theme.overrideAttrs (previousAttrs: {
      name = "where-is-my-sddm-next";
      src = pkgs.fetchFromGitHub {
        owner = "stepanzubkov";
        repo = "where-is-my-sddm-theme";
        rev = "v1.8.0";
        hash = "sha256-/D3i4QcE5+GbiAw32bFYJ7UxW/5NAl9FqQfiQc4akzI=";
      };
    })).override {
      themeConfig.General = {
        background = toString ./assets/IMG_20230723_1508433.jpg;
        backgroundMode = "fill";
      };
    })
    #xwaylandvideobridge
    #looking-glass-client
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

  #services.xserver.displayManager.sddm.wayland.enable = true;
  #services.xserver.displayManager.sddm.wayland.compositor = "kwin";
  #services.xserver.displayManager.sddm.theme = "where_is_my_sddm_theme";
  xdg.portal.enable = true;

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.xdgOpenUsePortal = true;

  programs.firefox.enable = false;
  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "fr";
    xkb.variant = "";
  };

  environment.variables = {
    GTK_USE_PORTAL = "1";
    #     PAGER = "most";
    #     MANPAGER = "nvim +Man!";
    #     EDITOR = "helix";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

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
    jack.enable = false;
  };
}
