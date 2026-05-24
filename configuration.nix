{
  config,
  pkgs,
  modulesPath,
  lib,
  ...
}:

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
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  ############################################################
  # System / Nix
  ############################################################
  system = {
    stateVersion = "26.05";

    autoUpgrade = {
      enable = false;
      allowReboot = false;
    };
  };

  nix = {
    settings = {

      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      cores = 0;
      max-jobs = "auto";
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  ############################################################
  # Boot / Hardware
  ############################################################
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    #kernelPackages = pkgs.linuxPackages_latest;
    #kernelPackages = pkgs.linuxPackages_latest-libre;
    consoleLogLevel = 3;
    kernel.sysctl = {
      "vm.swappiness" = 10;
    };

    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
      "vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166"
      "vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173"
      "vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200"
    ];

    kernelModules = [ "kvm-intel" ];

    initrd = {
      verbose = false;
      systemd = {
        enable = true;
        network.enable = true;
      };
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "uas"
        "usbhid"
        "sd_mod"
      ];

      kernelModules = [ ];
    };

    zswap = {
      enable = true;
      compressor = "zstd";
      maxPoolPercent = 15;
    };

    loader = {
      timeout = null;
      efi.canTouchEfiVariables = true;

      limine = {
        enable = true;

        secureBoot = {
          enable = true;
          autoGenerateKeys = true;

          autoEnrollKeys = {
            enable = true;
            extraArgs = [
              "--microsoft"
              "--firmware-builtin"
            ];
          };
        };

        #enableEditor = true;

        extraEntries = ''
          /Windows
            protocol: efi
            path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
        '';

        extraConfig = "timeout: no";

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

      font = "${pkgs.nerd-fonts.jetbrains-mono}/share/fonts/truetype/NerdFonts/JetBrainsMono/JetBrainsMonoNerdFont-Regular.ttf";

      themePackages = [
        (pkgs.catppuccin-plymouth.override {
          variant = catppuccin_style.variant;
        })
      ];
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    wooting.enable = true;

    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };
  };

  ############################################################
  # Storage
  ############################################################
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/2ec93e76-3e8c-40a0-b55e-33b728a501ee";
      fsType = "btrfs";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/7CA1-EA5A";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };

  swapDevices = [
    {
      device = lib.mkDefault "/dev/disk/by-uuid/6dc43f27-e48c-4c70-862e-dd3cfea918c3";
      label = "swap";
    }
  ];

  ############################################################
  # Networking
  ############################################################
  networking = {
    hostName = "loicdm-pc";
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = true;
      checkReversePath = "loose";
    };
  };

  ############################################################
  # Locale / Input
  ############################################################
  time.timeZone = "Europe/Paris";
  services.timesyncd.enable = false;
  services.chrony.enable = true;
  networking.timeServers = [
    "0.fr.pool.ntp.org"
    "1.fr.pool.ntp.org"
    "2.fr.pool.ntp.org"
    "3.fr.pool.ntp.org"
  ];

  i18n = {
    defaultLocale = "fr_FR.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
  };

  console = {
    useXkbConfig = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = [ pkgs.terminus_font ];
  };

  services.xserver.xkb.layout = "fr";

  ############################################################
  # Services (system)
  ############################################################
  services = {
    # Desktop
    desktopManager.plasma6.enable = true;

    displayManager = {
      sddm = {
        enable = false;
        wayland.enable = true;
        wayland.compositor = "kwin";
      };
      plasma-login-manager = {
        enable = true;
      };
    };

    # Audio
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      extraConfig.pipewire = {
        "91-virtual-sink" = {
          "context.modules" = [
            {
              name = "libpipewire-module-loopback";
              args = {
                "audio.channels" = 2;
                "audio.position" = [
                  "FL"
                  "FR"
                ];

                "capture.props" = {
                  "media.class" = "Audio/Sink";
                  "node.name" = "virtual_sink1";
                  "node.description" = "Virtual Sink 1";
                  "node.virtual" = true;
                };

                "playback.props" = {
                  "node.name" = "virtual_sink1.output";
                  "node.passive" = true;
                  "target.object" = "@DEFAULT_SINK@";
                };
              };
            }
          ];
        };
        "92-virtual-sink" = {
          "context.modules" = [
            {
              name = "libpipewire-module-loopback";
              args = {
                "audio.channels" = 2;
                "audio.position" = [
                  "FL"
                  "FR"
                ];

                "capture.props" = {
                  "media.class" = "Audio/Sink";
                  "node.name" = "virtual_sink2";
                  "node.description" = "Virtual Sink 2";
                  "node.virtual" = true;
                };

                "playback.props" = {
                  "node.name" = "virtual_sink2.output";
                  "node.passive" = true;
                  "target.object" = "@DEFAULT_SINK@";
                };
              };
            }
          ];
        };
        "93-virtual-sink" = {
          "context.modules" = [
            {
              name = "libpipewire-module-loopback";
              args = {
                "audio.channels" = 2;
                "audio.position" = [
                  "FL"
                  "FR"
                ];

                "capture.props" = {
                  "media.class" = "Audio/Sink";
                  "node.name" = "virtual_sink3";
                  "node.description" = "Virtual Sink 3";
                  "node.virtual" = true;
                };

                "playback.props" = {
                  "node.name" = "virtual_sink3.output";
                  "node.passive" = true;
                  "target.object" = "@DEFAULT_SINK@";
                };
              };
            }
          ];
        };
      };
    };

    # Performance
    tuned = {
      enable = true;
      ppdSettings.main.default = "performance";
    };

    power-profiles-daemon.enable = false;
  };

  programs.gamemode.enable = true;

  ############################################################
  # Virtualisation
  ############################################################
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
    };

    docker.enable = true;
  };

  ############################################################
  # Users
  ############################################################
  users.users = {
    loicdm = {
      isNormalUser = true;
      description = "Loïc Daudé Mondet";
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
        "libvirtd"
      ];
    };

    sasha = {
      isNormalUser = true;
      description = "Claire Perreaux";
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
        "libvirtd"
      ];
    };

    root.shell = pkgs.fish;
  };

  ############################################################
  # Programs / CLI
  ############################################################
  programs = {
    #command-not-found.enable = true;
    direnv.enable = true;
    #nix-index.enable = true;
    fish = {
      enable = true;

      interactiveShellInit = ''
        set -g fish_greeting
        set --export SSH_AUTH_SOCK '/home/loicdm/.bitwarden-ssh-agent.sock'
      '';

      shellInit = ''
        source ${./fish/catppuccin-mocha.fish}
      '';

      shellAliases = {
        rdry = "sudo nixos-rebuild dry-run --flake";
        rbuild = "sudo nixos-rebuild build --flake";
        rswitch = "sudo nixos-rebuild switch --flake";

        ns = "nix-shell --command fish";
        nsp = "ns -p";

        ls = "eza --icons --group-directories-first --git -@ --git-repos --header --group --created --modified";
        ll = "ls -l";
        la = "ls -al";

        ffa = "fastfetch -c all";
      };
    };

    starship = {
      enable = true;
      settings = import ./starship/starship.nix;
    };

    git.enable = true;

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

    virt-manager.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;

      extraCompatPackages = with pkgs; [
        proton-ge-bin
        catppuccin-cursors.mochaMauve
        catppuccin-cursors.mochaDark
      ];
    };

    partition-manager.enable = true;
  };

  ############################################################
  # Environment / Packages
  ############################################################
  environment = {
    variables = {
      AMD_VULKAN_ICD = "RADV";
      RADV_PERFTEST = "aco";
    };
    systemPackages = with pkgs; [
      sbctl
      man-pages
      man-pages-posix
      fastfetch
      htop
      btop
      nvtopPackages.amd
      kdePackages.sddm-kcm
      efibootmgr
      ntfs3g
      #dnsmasq

      # Theming
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

      (catppuccin-papirus-folders.override {
        flavor = catppuccin_style.variant;
        accent = catppuccin_style.accent;
      })
    ];
  };
  ############################################################
  # Fonts
  ############################################################
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
      };
    };

    packages = with pkgs; [
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      nerd-fonts.jetbrains-mono
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
