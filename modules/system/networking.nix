{ lib, pkgs, config, ... }: {
  networking.hostName = "loicdm-pc"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
#   services.samba.enable = true;
#   services.samba.openFirewall = true;
#   services.samba.shares = {
#     public = {
#       path = "/home/loicdm/Document/samba";
#       "read only" = false;
#       browseable = "yes";
#       "guest ok" = "yes";
#       comment = "Public samba share.";
#     };
#   };
#   services.samba-wsdd = {
#     enable = true;
#     openFirewall = true;
#   };

  # Open ports in the firewall.
#   networking.firewall.allowedTCPPorts = [ 44 ];
#   networking.firewall.allowedUDPPorts = [ 44 ];
  # Or disable the firewall altogether.

  networking.firewall.enable = true;

  #    networking.wg-quick.interfaces = {
  #    wg0 = {
  #      address = [ "10.13.13.2/24" ];
  #      dns = [ "10.13.13.1"];
  #      privateKey = "KCAVDRJGGAcsn14UDeGAll7a6zZWZLBFMNxNvfGIS1U=";
  #      listenPort = 51820;
  #      
  #      peers = [
  #        {        
  #          publicKey = "joHNX3HM1Ca5cA0/pXkwW3QbZ849BEuAp2q4apfJmHI=";
  #presharedKey = "kWXmKVwpzIzZe1F+oLw2WPXzofrCO/lLmThRvEVm90g=";
  #endpoint = "cloud.mondet.fr:51820";
  #allowedIPs = [ "0.0.0.0/0" ];
  #        }
  #      ];
  #    };
  #  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;
}
