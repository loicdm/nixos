{
  pkgs,
  ...
}:

{
  ############################################################
  # Imports
  ############################################################
  imports = [
    ./hardware-configuration.nix
  ];

  ############################################################
  # Nix & System
  ############################################################
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system = {
    autoUpgrade = {
      enable = false;
      allowReboot = false;
    };
    stateVersion = "25.11";
  };

  ############################################################
  # Bootloader & Boot
  ############################################################
  boot = {
    loader = {
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

    kernelPackages = pkgs.linuxPackages_zen;

    plymouth = {
      enable = true;
      theme = "catppuccin-mocha";
      font = "${pkgs.nerd-fonts.iosevka}/share/fonts/truetype/NerdFonts/Iosevka/IosevkaNerdFont-Regular.ttf";
      themePackages = [
        (pkgs.catppuccin-plymouth.override {
          variant = "mocha";
        })
      ];
    };

    consoleLogLevel = 3;
    initrd = {
      verbose = false;
      systemd.enable = true;
    };

    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
      "vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166"
      "vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173"
      "vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200"
    ];

    loader.timeout = null;
  };

  ############################################################
  # Hardware
  ############################################################
  hardware.openrazer.enable = true;
  hardware.amdgpu.initrd.enable = true;
  hardware.amdgpu.opencl.enable = true;

  ############################################################
  # Networking
  ############################################################
  networking = {
    hostName = "loicdm-pc";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  ############################################################
  # Locale & Time
  ############################################################
  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "fr_FR.UTF-8";

  console = {
    useXkbConfig = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = [ pkgs.terminus_font ];
  };

  ############################################################
  # Power & Performance
  ############################################################
  services = {
    tuned = {
      enable = true;
      ppdSettings.main.default = "performance";
    };

    power-profiles-daemon.enable = false;
  };

  programs.gamemode.enable = true;

  ############################################################
  # Desktop (Plasma 6 + SDDM)
  ############################################################
  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      compositor = "kwin";
    };
    theme = "${
      pkgs.catppuccin-sddm.override {
        flavor = "mocha";
        accent = "mauve";
        userIcon = true;
      }
    }/share/sddm/themes/catppuccin-mocha-mauve";
  };

  services.xserver.xkb.layout = "fr";

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

    packages = with pkgs; [
      razergenie
      prismlauncher
      bitwarden-desktop
      vesktop
      zed-editor
      nil
      nixd
      obs-studio
      (kdePackages.kdenlive.override { ffmpeg-full = pkgs.ffmpeg_7-full; })
    ];
  };

  ############################################################
  # Programs
  ############################################################
  programs = {
    firefox.enable = true;

    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
    };

    starship = {
      enable = true;
      settings = import ./starship.nix;
    };
  };

  environment.shellAliases = {
    rebuild-dry = "sudo nixos-rebuild dry-run --flake";
    rebuild-build = "sudo nixos-rebuild build --flake";
    rebuild-switch = "sudo nixos-rebuild switch --flake";
    ls = "eza --icons --group-directories-first --git -@ --git-repos --header --group --created --modified";
    ll = "ls -l";
    la = "ls -al";
  };

  environment.variables = {
    GTK_USE_PORTAL = "1";
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.xdgOpenUsePortal = true;

  ############################################################
  # Environment Packages
  ############################################################
  environment.systemPackages = with pkgs; [
    sbctl
    eza
    # man pages
    man-pages
    man-pages-posix
    # Catppuccin
    catppuccin-cursors.mochaMauve
    catppuccin-cursors.mochaDark
    (catppuccin.override {
      variant = "mocha";
      accent = "mauve";
    })
    (catppuccin-kde.override {
      flavour = [ "mocha" ];
      accents = [ "mauve" ];
    })
    (catppuccin-gtk.override {
      variant = "mocha";
      accents = [ "mauve" ];
    })
    (catppuccin-kvantum.override {
      variant = "mocha";
      accent = "mauve";
    })
    (catppuccin-papirus-folders.override {
      flavor = "mocha";
      accent = "mauve";
    })
  ];

  ############################################################
  # Fonts
  ############################################################
  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    twitter-color-emoji
    symbola
  ];

  fonts.fontDir.enable = true;

  ############################################################
  # Security
  ############################################################
  security.sudo.extraConfig = "Defaults pwfeedback";

  ############################################################
  # Misc
  ############################################################

  # Development man pages
  documentation.dev.enable = true;
  documentation.man = {
    # In order to enable to mandoc man-db has to be disabled.
    man-db.enable = true;
    mandoc.enable = false;
  };
  programs.less.enable = true;
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      prettybat
    ];
    settings = {
      theme = "'Catppuccin Mocha'";
    };
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
  };
  programs.git = {
    enable = true;
  };
  programs.thunderbird.enable = true;

}
