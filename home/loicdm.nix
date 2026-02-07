{ pkgs, ... }:

{
  ############################################################
  # Home Manager identity
  ############################################################
  home = {
    username = "loicdm";
    homeDirectory = "/home/loicdm";
    stateVersion = "25.11";

    sessionVariables = {
      GTK_USE_PORTAL = "1";
    };

    packages = with pkgs; [
      # CLI
      eza

      # Apps
      razergenie
      prismlauncher
      bitwarden-desktop
      vesktop
      zed-editor
      obs-studio
      kdePackages.kdenlive
      onlyoffice-desktopeditors

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
        "Iosevka Nerd Font"
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

    ##########################################################
    # Browser / Mail
    ##########################################################
    firefox.enable = true;

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
