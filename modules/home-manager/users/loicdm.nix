{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "loicdm";
  home.homeDirectory = "/home/loicdm";
#  home.packages = with pkgs; [
#  	#kitty
#	wofi
#     #
#  ];
#  programs.kitty = {
#  	enable = true;
#	font = {
#		name = "JetBrainsMono NF Regular";
#	};
#	shellIntegration.enableZshIntegration = true;
#	theme = "Dracula";
#  };
#
#  programs.waybar = {
#	enable = true;
#	settings = {
#  mainBar = {
#    layer = "top";
#    position = "top";
#    height = 30;
#    modules-left = [ "hyprland/workspaces" "wlr/taskbar" ];
#    modules-center = [ "hyprland/window" ];
#    modules-right = [ "tray" "pulseaudio" "network" "privacy" "power-profiles-daemon" "backlight/slider" "battery" "clock" "cpu" "memory" "temperature" ];
#    "clock" = {      
#    interval = 1;      
#    format = "{:%H:%M:%S}";  
#    };
#    "backlight/slider" = {
#    min = 20;
#    max =  100;
#    orientation = "horizontal";
#};
#  };
#};
#
#style = ''
#
#* {
#    /* `otf-font-awesome` is required to be installed for icons */
#    font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
#    font-size: 13px;
#}
#
#window#waybar {
#    background-color: rgba(43, 48, 59, 0.5);
#    border-bottom: 3px solid rgba(100, 114, 125, 0.5);
#    color: #ffffff;
#    transition-property: background-color;
#    transition-duration: .5s;
#}
#
#window#waybar.hidden {
#    opacity: 0.2;
#}
#
#/*
#window#waybar.empty {
#    background-color: transparent;
#}
#window#waybar.solo {
#    background-color: #FFFFFF;
#}
#*/
#
#window#waybar.termite {
#    background-color: #3F3F3F;
#}
#
#window#waybar.chromium {
#    background-color: #000000;
#    border: none;
#}
#
#button {
#    /* Use box-shadow instead of border so the text isn't offset */
#    box-shadow: inset 0 -3px transparent;
#    /* Avoid rounded borders under each button name */
#    border: none;
#    border-radius: 0;
#}
#
#/* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
#button:hover {
#    background: inherit;
#    box-shadow: inset 0 -3px #ffffff;
#}
#
##workspaces button {
#    padding: 0 5px;
#    background-color: transparent;
#    color: #ffffff;
#}
#
##workspaces button:hover {
#    background: rgba(0, 0, 0, 0.2);
#}
#
##workspaces button.focused {
#    background-color: #64727D;
#    box-shadow: inset 0 -3px #ffffff;
#}
#
##workspaces button.urgent {
#    background-color: #eb4d4b;
#}
#
##mode {
#    background-color: #64727D;
#    box-shadow: inset 0 -3px #ffffff;
#}
#
##clock,
##battery,
##cpu,
##memory,
##disk,
##temperature,
##backlight,
##network,
##pulseaudio,
##wireplumber,
##custom-media,
##tray,
##mode,
##idle_inhibitor,
##scratchpad,
##power-profiles-daemon,
##mpd {
#    padding: 0 10px;
#    color: #ffffff;
#}
#
##window,
##workspaces {
#    margin: 0 4px;
#}
#
#/* If workspaces is the leftmost module, omit left margin */
#.modules-left > widget:first-child > #workspaces {
#    margin-left: 0;
#}
#
#/* If workspaces is the rightmost module, omit right margin */
#.modules-right > widget:last-child > #workspaces {
#    margin-right: 0;
#}
#
##clock {
#    background-color: #64727D;
#}
#
##battery {
#    background-color: #ffffff;
#    color: #000000;
#}
#
##battery.charging, #battery.plugged {
#    color: #ffffff;
#    background-color: #26A65B;
#}
#
#@keyframes blink {
#    to {
#        background-color: #ffffff;
#        color: #000000;
#    }
#}
#
#/* Using steps() instead of linear as a timing function to limit cpu usage */
##battery.critical:not(.charging) {
#    background-color: #f53c3c;
#    color: #ffffff;
#    animation-name: blink;
#    animation-duration: 0.5s;
#    animation-timing-function: steps(12);
#    animation-iteration-count: infinite;
#    animation-direction: alternate;
#}
#
##power-profiles-daemon {
#    padding-right: 15px;
#}
#
##power-profiles-daemon.performance {
#    background-color: #f53c3c;
#    color: #ffffff;
#}
#
##power-profiles-daemon.balanced {
#    background-color: #2980b9;
#    color: #ffffff;
#}
#
##power-profiles-daemon.power-saver {
#    background-color: #2ecc71;
#    color: #000000;
#}
#
#label:focus {
#    background-color: #000000;
#}
#
##cpu {
#    background-color: #2ecc71;
#    color: #000000;
#}
#
##memory {
#    background-color: #9b59b6;
#}
#
##disk {
#    background-color: #964B00;
#}
#
##backlight {
#    background-color: #90b1b1;
#}
#
##network {
#    background-color: #2980b9;
#}
#
##network.disconnected {
#    background-color: #f53c3c;
#}
#
##pulseaudio {
#    background-color: #f1c40f;
#    color: #000000;
#}
#
##pulseaudio.muted {
#    background-color: #90b1b1;
#    color: #2a5c45;
#}
#
##wireplumber {
#    background-color: #fff0f5;
#    color: #000000;
#}
#
##wireplumber.muted {
#    background-color: #f53c3c;
#}
#
##custom-media {
#    background-color: #66cc99;
#    color: #2a5c45;
#    min-width: 100px;
#}
#
##custom-media.custom-spotify {
#    background-color: #66cc99;
#}
#
##custom-media.custom-vlc {
#    background-color: #ffa000;
#}
#
##temperature {
#    background-color: #f0932b;
#}
#
##temperature.critical {
#    background-color: #eb4d4b;
#}
#
##tray {
#    background-color: #2980b9;
#}
#
##tray > .passive {
#    -gtk-icon-effect: dim;
#}
#
##tray > .needs-attention {
#    -gtk-icon-effect: highlight;
#    background-color: #eb4d4b;
#}
#
##idle_inhibitor {
#    background-color: #2d3436;
#}
#
##idle_inhibitor.activated {
#    background-color: #ecf0f1;
#    color: #2d3436;
#}
#
##mpd {
#    background-color: #66cc99;
#    color: #2a5c45;
#}
#
##mpd.disconnected {
#    background-color: #f53c3c;
#}
#
##mpd.stopped {
#    background-color: #90b1b1;
#}
#
##mpd.paused {
#    background-color: #51a37a;
#}
#
##language {
#    background: #00b093;
#    color: #740864;
#    padding: 0 5px;
#    margin: 0 5px;
#    min-width: 16px;
#}
#
##keyboard-state {
#    background: #97e1ad;
#    color: #000000;
#    padding: 0 0px;
#    margin: 0 5px;
#    min-width: 16px;
#}
#
##keyboard-state > label {
#    padding: 0 5px;
#}
#
##keyboard-state > label.locked {
#    background: rgba(0, 0, 0, 0.2);
#}
#
##scratchpad {
#    background: rgba(0, 0, 0, 0.2);
#}
#
##scratchpad.empty {
#	background-color: transparent;
#}
#
##privacy {
#    padding: 0;
#}
#
##privacy-item {
#    padding: 0 5px;
#    color: white;
#}
#
##privacy-item.screenshare {
#    background-color: #cf5700;
#}
#
##privacy-item.audio-in {
#    background-color: #1ca000;
#}
#
##privacy-item.audio-out {
#    background-color: #0069d4;
#}
#
##pulseaudio-slider trough, #backlight-slider trough {
#    min-height: 10px;
#    min-width: 80px;
#}
#'';
#  };
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
      update = "sudo nixos-rebuild boot --flake ~/Documents/nixos/#loicdm-pcp --upgrade-all";
      ip = "ip --color";
    };
    initExtra =
    ''
    # create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="''${terminfo[khome]}"
key[End]="''${terminfo[kend]}"
key[Insert]="''${terminfo[kich1]}"
key[Backspace]="''${terminfo[kbs]}"
key[Delete]="''${terminfo[kdch1]}"
key[Up]="''${terminfo[kcuu1]}"
key[Down]="''${terminfo[kcud1]}"
key[Left]="''${terminfo[kcub1]}"
key[Right]="''${terminfo[kcuf1]}"
key[PageUp]="''${terminfo[kpp]}"
key[PageDown]="''${terminfo[knp]}"
key[Shift-Tab]="''${terminfo[kcbt]}"

# setup key accordingly
[[ -n "''${key[Home]}"      ]] && bindkey -- "''${key[Home]}"       beginning-of-line
[[ -n "''${key[End]}"       ]] && bindkey -- "''${key[End]}"        end-of-line
[[ -n "''${key[Insert]}"    ]] && bindkey -- "''${key[Insert]}"     overwrite-mode
[[ -n "''${key[Backspace]}" ]] && bindkey -- "''${key[Backspace]}"  backward-delete-char
[[ -n "''${key[Delete]}"    ]] && bindkey -- "''${key[Delete]}"     delete-char
[[ -n "''${key[Up]}"        ]] && bindkey -- "''${key[Up]}"         up-line-or-history
[[ -n "''${key[Down]}"      ]] && bindkey -- "''${key[Down]}"       down-line-or-history
[[ -n "''${key[Left]}"      ]] && bindkey -- "''${key[Left]}"       backward-char
[[ -n "''${key[Right]}"     ]] && bindkey -- "''${key[Right]}"      forward-char
[[ -n "''${key[PageUp]}"    ]] && bindkey -- "''${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "''${key[PageDown]}"  ]] && bindkey -- "''${key[PageDown]}"   end-of-buffer-or-history
[[ -n "''${key[Shift-Tab]}" ]] && bindkey -- "''${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from ''$terminfo valid.
if (( ''${+terminfo[smkx]} && ''${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "''${key[Up]}"   ]] && bindkey -- "''${key[Up]}"   up-line-or-beginning-search
[[ -n "''${key[Down]}" ]] && bindkey -- "''${key[Down]}" down-line-or-beginning-search

key[Control-Left]="''${terminfo[kLFT5]}"
key[Control-Right]="''${terminfo[kRIT5]}"

key[Alt-Left]="''${terminfo[kLFT3]}"
key[Alt-Right]="''${terminfo[kRIT3]}"

[[ -n "''${key[Control-Left]}"  ]] && bindkey -- "''${key[Control-Left]}" backward-word
[[ -n "''${key[Control-Right]}" ]] && bindkey -- "''${key[Control-Right]}" forward-word

[[ -n "''${key[Alt-Left]}"  ]] && bindkey -- "''${key[Alt-Left]}" backward-word
[[ -n "''${key[Alt-Right]}" ]] && bindkey -- "''${key[Alt-Right]}" forward-word

'';
  };



# wayland.windowManager.hyprland.enable = true;
#
#wayland.windowManager.hyprland.settings = {
#exec-once="waybar";
#input = {
#kb_layout = "fr";
#};
#monitor=",prefered,auto,1";
#"$menu" = "wofi --show drun";
#general = {
#	layout = "master";
#};
#
#master = {
#new_is_master = true;
#};
#
#"$mod" = "SUPER";
#
#
#    bind =
#      [
#        "$mod, RETURN, exec, kitty"
#	"$mod, R, exec, $menu"
#	"$mod SHIFT, C, killactive"
#	"$mod, V, togglefloating"
#
#
#      ]
#      ++ (
#        # workspaces
#        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
#        builtins.concatLists (builtins.genList (
#            x: let
#              ws = let
#                c = (x + 1) / 10;
#              in
#                builtins.toString (x + 1 - (c * 10));
#            in [
#              "$mod, ${ws}, workspace, ${toString (x + 1)}"
#              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
#            ]
#          )
#          10)
#      );
#
#      };


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
