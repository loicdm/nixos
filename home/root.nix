{ pkgs, ... }:

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
  };

  ############################################################
  # XDG / Portals
  ############################################################
  xdg.portal = {
    xdgOpenUsePortal = true;
  };
}
