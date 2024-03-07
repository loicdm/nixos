

{ lib, pkgs, config, ... }: {

  # Sudo password feedback
  security.sudo.extraConfig = "Defaults pwfeedback";
  environment.pathsToLink = [ "/share/zsh" ];

  environment.variables = {
    #     PAGER = "most";
    #     MANPAGER = "nvim +Man!";
    #     EDITOR = "helix";
  };
}

