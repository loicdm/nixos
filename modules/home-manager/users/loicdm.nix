{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "loicdm";
  home.homeDirectory = "/home/loicdm";
  home.packages = with pkgs; [
      keepassxc
      nextcloud-client
      discord
      neovim
      kdePackages.kate
      wl-clipboard
      wireguard-tools
      git
      # python3
      hunspellDicts.fr-any
     libreoffice-qt
#      nerdfonts
      zoom-us
      vlc
      btop
      # prismlauncher-qt5
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
      kdePackages.partitionmanager
      eza
  ];

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
         add_newline = true;
         character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
       };
        os = {
          disabled = false;
        };
        sudo = {
          disabled = false;
        };
        directory = {
          truncation_length = 5;
          #fish_style_pwd_dir_length = 5;
          truncate_to_repo = true;
        };
        username = {
          show_always = false;
        };
    };
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "eza --icons --group-directories-first --git -@ --git-repos --header --group --created --modified";
      ll = "ls -l";
      la = "ls -la";
      l = "ls";
      update = "sudo nixos-rebuild switch --flake ~/Documents/nixos/#loicdm-pcp --upgrade-all";
  };
  };


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
