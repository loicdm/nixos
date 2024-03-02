{
  lib,
  pkgs,
  config,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.loicdm = {
    isNormalUser = true;
    description = "Loïc Daudé Mondet";
    extraGroups = ["networkmanager" "wheel" "libvirtd" "vboxusers" "jupyter"];
    initialPassword = "password";
    packages = with pkgs; [
      keepassxc
      nextcloud-client
      discord
      # gnomeExtensions.dash-to-panel
      # gnomeExtensions.arcmenu
      # gnomeExtensions.appindicator
      # gnomeExtensions.quick-settings-tweaker
      # gnomeExtensions.clipboard-indicator
      # gnome.gnome-tweaks
      # gnome-console
      # # gnome.gnome-boxes
      # gnome-text-editor
      # obsidian
      neovim
      kdePackages.kate
      # xsel
      wl-clipboard
      wireguard-tools
      git
      # python3
      hunspellDicts.fr-any
     #  libreoffice-qt
#      nerdfonts
      virt-manager
      # zoom-us
      vlc
      btop
      # prismlauncher-qt5
      #gnome.gnome-sound-recorder
      #qjackctl
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
      # libsForQt5.plasma-browser-integration
      kdePackages.partitionmanager
    ];
  };
}
