{ config, pkgs, ... }:
let
  catppuccin_style = {
    variant = "mocha";
    accent = "mauve";
  };
in
{
  home.username = "loicdm";
  home.homeDirectory = "/home/loicdm";

  home.stateVersion = "25.11";

  ############################################################
  # Home packages (user)
  ############################################################
  home.packages = with pkgs; [
    razergenie
    prismlauncher
    bitwarden-desktop
    vesktop
    zed-editor
    nil
    nixd
    obs-studio
    kdePackages.kdenlive
    onlyoffice-desktopeditors

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
    kdePackages.sddm-kcm

  ];

  home.sessionVariables = {
    GTK_USE_PORTAL = "1";
  };

  fonts = {
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
  # Programs (user-level)
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

    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
    };

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

  xdg.portal = {
    xdgOpenUsePortal = true;
  };

  programs.home-manager.enable = true;
}
