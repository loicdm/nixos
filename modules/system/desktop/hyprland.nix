{
  lib,
  pkgs,
  config,
  ...
}: {
  # Enable the X11 windowing system.
  # services.xserver.enable = true;

   programs.hyprland.enable = true;
   services.greetd = {
  enable = true;
};
programs.regreet.enable = true;
  environment.systemPackages = with pkgs; [
   keepassxc
      nextcloud-client
      discord
      neovim
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
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
            eza
      papirus-icon-theme

  ];
fonts.fontDir.enable = true;
fonts.packages = with pkgs; [

	 (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
];


    xdg.portal.enable = true;

  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
	pkgs.xdg-desktop-portal-kde

  ];
  xdg.portal.xdgOpenUsePortal = true;

  programs.firefox.enable = true;
  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "fr";
    xkb.variant = "";
  };

    environment.variables = {
    XKB_DEFAULT_LAYOUT = "fr";
     # GTK_USE_PORTAL = "1";
#     PAGER = "most";
#     MANPAGER = "nvim +Man!";
#     EDITOR = "helix";
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
