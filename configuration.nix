{ pkgs, ... }:

let
  catppuccin_style = {
    variant = "mocha";
    accent = "mauve";
  };
in
{
  ############################################################
  # Imports
  ############################################################
  imports = [
    ./hardware-configuration.nix
  ];

  ############################################################
  # System / Nix
  ############################################################
  system.stateVersion = "25.11";

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system.autoUpgrade = {
    enable = false;
    allowReboot = false;
  };

  ############################################################
  # Boot
  ############################################################
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
      "vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166"
      "vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173"
      "vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200"
      "zswap.enabled=1" # enables zswap
      "zswap.compressor=zstd" # compression algorithm
      "zswap.max_pool_percent=20" # maximum percentage of RAM that zswap is allowed to use
      "zswap.shrinker_enabled=1" # whether to shrink the pool proactively on high memory pressure
    ];

    initrd = {
      verbose = false;
      systemd.enable = true;
    };

    loader = {
      timeout = null;
      efi.canTouchEfiVariables = true;

      limine = {
        enable = true;
        secureBoot.enable = true;

        style = {
          interface.resolution = "1920x1200";
          wallpapers = [ ];

          graphicalTerminal = {
            background = "1e1e2e";
            brightBackground = "585b70";
            foreground = "cdd6f4";
            brightForeground = "cdd6f4";
            palette = "1e1e2e;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4";
            brightPalette = "585b70;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4";
          };
        };
      };
    };

    plymouth = {
      enable = true;
      theme = "catppuccin-mocha";
      font = "${pkgs.nerd-fonts.iosevka}/share/fonts/truetype/NerdFonts/Iosevka/IosevkaNerdFont-Regular.ttf";
      themePackages = [
        (pkgs.catppuccin-plymouth.override {
          variant = catppuccin_style.variant;
        })
      ];
    };
  };

  ############################################################
  # Hardware
  ############################################################
  hardware = {
    openrazer.enable = true;
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };
  };

  ############################################################
  # Networking
  ############################################################
  networking = {
    hostName = "loicdm-pc";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  ############################################################
  # Locale / Console
  ############################################################
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";

  console = {
    useXkbConfig = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = [ pkgs.terminus_font ];
  };

  services.xserver.xkb.layout = "fr";

  ############################################################
  # Power / Performance
  ############################################################
  services.tuned = {
    enable = true;
    ppdSettings.main.default = "performance";
  };

  services.power-profiles-daemon.enable = false;
  programs.gamemode.enable = true;

  ############################################################
  # Desktop (Plasma 6 + SDDM)
  ############################################################
  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    wayland.compositor = "kwin";

    # theme = "${
    #   pkgs.catppuccin-sddm.override {
    #     flavor = catppuccin_style.variant;
    #     accent = catppuccin_style.accent;
    #     userIcon = true;
    #   }
    # }/share/sddm/themes/catppuccin-mocha-mauve";
  };

  ############################################################
  # Audio
  ############################################################
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  ############################################################
  # Users
  ############################################################
  users.users.loicdm = {
    isNormalUser = true;
    description = "Loïc Daudé Mondet";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "openrazer"
    ];
  };
  users.users.root.shell = pkgs.fish;

  ############################################################
  # Programs
  ############################################################
  programs = {
    fish.enable = true;
    steam = {
      enable = true; # Master switch, already covered in installation
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports for Source Dedicated Server hosting
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

  };

  ############################################################
  # Environment
  ############################################################
  environment = {
    systemPackages = with pkgs; [
      sbctl
      man-pages
      man-pages-posix
      fastfetch
      htop
      btop
      nvtopPackages.amd
      kdePackages.sddm-kcm
    ];
  };

  ############################################################
  # Fonts
  ############################################################
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      twitter-color-emoji
      symbola
    ];
  };

  ############################################################
  # Security / Docs
  ############################################################
  security.sudo.extraConfig = "Defaults pwfeedback";

  documentation = {
    dev.enable = true;
    man = {
      man-db.enable = true;
      mandoc.enable = false;
    };
  };
}
