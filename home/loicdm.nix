{ pkgs, ... }:

let
  catppuccin_style = {
    variant = "mocha";
    accent = "mauve";
  };
in
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

      # KDE tools
      kdePackages.sddm-kcm
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

    ##########################################################
    # Dev tools
    ##########################################################
    git.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
    };

    ##########################################################
    # Shell
    ##########################################################
    fish = {
      enable = true;

      interactiveShellInit = ''
        # Désactive le greeting
        set -g fish_greeting

        # Bitwarden SSH Agent socket
        set --export SSH_AUTH_SOCK '/home/loicdm/.bitwarden-ssh-agent.sock'
      '';

      shellInit = ''
        # Charge le thème Catppuccin Mocha
        source ${../fish/catppuccin-mocha.fish}
      '';

      shellAliases = {
        rebuild-dry = "sudo nixos-rebuild dry-run --flake";
        rebuild-build = "sudo nixos-rebuild build --flake";
        rebuild-switch = "sudo nixos-rebuild switch --flake";

        ls = "eza --icons --group-directories-first --git -@ --git-repos --header --group --created --modified";
        ll = "ls -l";
        la = "ls -al";
      };
    };

    starship = {
      enable = true;
      settings = import ../starship/starship.nix;
    };

    ##########################################################
    # CLI utilities
    ##########################################################
    bat = {
      enable = true;
      config.theme = "Catppuccin Mocha";

      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        prettybat
      ];
    };
  };

  ############################################################
  # XDG / Portals
  ############################################################
  xdg.portal = {
    xdgOpenUsePortal = true;
  };
}
