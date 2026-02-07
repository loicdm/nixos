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
    username = "root";
    homeDirectory = "/root";
    stateVersion = "25.11";

    sessionVariables = {
      GTK_USE_PORTAL = "1";
    };

    packages = with pkgs; [
      # CLI
      eza

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
      '';

      shellInit = ''
        # Charge le thème Catppuccin Mocha
        source ${../fish/catppuccin-mocha.fish}
      '';

      shellAliases = {
        rebuild-dry = "nixos-rebuild dry-run --flake";
        rebuild-build = "nixos-rebuild build --flake";
        rebuild-switch = "nixos-rebuild switch --flake";

        ls = "eza --icons --group-directories-first --git -@ --git-repos --header --group --created --modified";
        ll = "ls -l";
        la = "ls -al";
      };
      functions.nsp = {
        body = ''
          nix-shell -p $argv --command fish
        '';
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
