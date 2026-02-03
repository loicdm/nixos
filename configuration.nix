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

    theme = "${
      pkgs.catppuccin-sddm.override {
        flavor = catppuccin_style.variant;
        accent = catppuccin_style.accent;
        userIcon = true;
      }
    }/share/sddm/themes/catppuccin-mocha-mauve";
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

    packages = with pkgs; [
      razergenie
      prismlauncher
      bitwarden-desktop
      vesktop
      zed-editor
      nil
      nixd
      obs-studio
      (kdePackages.kdenlive.override {
        ffmpeg-full = pkgs.ffmpeg_7-full;
      })
    ];
  };

  ############################################################
  # Programs
  ############################################################
  programs = {
    firefox.enable = true;
    thunderbird.enable = true;
    git.enable = true;

    fish = {
      enable = true;
      interactiveShellInit = ''
        # Désactive le greeting
        set -g fish_greeting
      '';

      shellInit = ''
        # Charge le thème Catppuccin Mocha
        source ${./fish/catppuccin-mocha.fish}
      '';
    };

    starship = {
      enable = true;
      settings = import ./starship/starship.nix;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
    };

    bat = {
      enable = true;
      settings.theme = "'Catppuccin Mocha'";
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        prettybat
      ];
    };

    less.enable = true;
  };

  ############################################################
  # Environment
  ############################################################
  environment = {
    variables.GTK_USE_PORTAL = "1";

    shellAliases = {
      rebuild-dry = "sudo nixos-rebuild dry-run --flake";
      rebuild-build = "sudo nixos-rebuild build --flake";
      rebuild-switch = "sudo nixos-rebuild switch --flake";
      ls = "eza --icons --group-directories-first --git -@ --git-repos --header --group --created --modified";
      ll = "ls -l";
      la = "ls -al";
    };

    systemPackages = with pkgs; [
      sbctl
      eza
      man-pages
      man-pages-posix
      fastfetch
      htop
      btop

      catppuccin-cursors.mochaMauve
      catppuccin-cursors.mochaDark

      (catppuccin.override catppuccin_style)
      (catppuccin-kde.override {
        flavour = [ catppuccin_style.variant ];
        accents = [ catppuccin_style.accent ];
      })
      (catppuccin-gtk.override {
        variant = catppuccin_style.variant;
        accents = [ catppuccin_style.accent ];
      })
      (catppuccin-kvantum.override catppuccin_style)
      (catppuccin-papirus-folders.override {
        flavor = catppuccin_style.variant;
        accent = catppuccin_style.accent;
      })
    ];
  };

  ############################################################
  # XDG / Portals
  ############################################################
  xdg.portal = {
    xdgOpenUsePortal = true;
  };

  ############################################################
  # Fonts
  ############################################################
  fonts = {
    packages = with pkgs; [
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      twitter-color-emoji
      symbola
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [
          "Noto Serif"
          "Noto Color Emoji"
        ];
        sansSerif = [
          "Noto Sans"
          "Noto Color Emoji"
        ];
        monospace = [
          "Iosevka Nerd Font"
          "Noto Color Emoji"
        ];
      };
      hinting = {
        enable = true;
        style = "slight";
      };
    };
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
