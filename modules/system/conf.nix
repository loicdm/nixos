

{
  lib,
  pkgs,
  config,
  ...
}: {

  # Sudo password feedback
  security.sudo.extraConfig = "Defaults pwfeedback";
  environment.pathsToLink = [ "/share/zsh" ];

  environment.variables = {
      GTK_USE_PORTAL = "1";
#     PAGER = "most";
#     MANPAGER = "nvim +Man!";
#     EDITOR = "helix";
  };
}

