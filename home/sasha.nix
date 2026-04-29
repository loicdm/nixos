{ pkgs, ... }:

{
  ############################################################
  # Home Manager identity
  ############################################################
  home = {
    username = "sasha";
    homeDirectory = "/home/sasha";
    stateVersion = "26.05";

    sessionVariables = {
      GTK_USE_PORTAL = "1";
    };

    packages = with pkgs; [
      # CLI
      eza

      # Apps
      #razergenie
      prismlauncher
      bitwarden-desktop
      zed-editor
      obs-studio
      kdePackages.kdenlive
      onlyoffice-desktopeditors
      zapzap
      #mpv

      # Nix tooling
      nil
      nixd

    ];
  };

  ############################################################
  # Fonts (user-level fontconfig)
  ############################################################
  fonts.fontconfig = {
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
        "JetBrainsMono Nerd Font"
        "Noto Color Emoji"
      ];
    };

    hinting = "slight";
  };

  ############################################################
  # Programs
  ############################################################
  programs = {
    home-manager.enable = true;
    vesktop = {
      enable = true;
      settings = import ./vesktop/settings.nix;
    };
    discord = {
      enable = true;
      settings = {
        SKIP_HOST_UPDATE = true;
      };
    };
    ##########################################################
    # Browser / Mail
    ##########################################################
    firefox = {
      enable = true;
      nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];
      languagePacks = [
        "fr"
        "en-US"
      ];
      profiles = {
        loicdm = {
          isDefault = true;
          settings = {
            "widget.use-xdg-desktop-portal.file-picker" = 1;
          };
        };
      };
    };

    thunderbird = {
      enable = true;
      profiles = {
        loicdm = {
          isDefault = true;
        };
      };
    };

  };

  ############################################################
  # XDG / Portals
  ############################################################
  xdg.portal = {
    xdgOpenUsePortal = true;
  };
}
