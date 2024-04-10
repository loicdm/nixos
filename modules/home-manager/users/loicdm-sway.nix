{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "loicdm";
  home.homeDirectory = "/home/loicdm";
  home.packages = with pkgs; [ swayest-workstyle neovim];

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    settings."org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "kitty";
      menu = "fuzzel -T kitty";
      output = {
        #"*" = {
          #bg = "../../../assets/IMG_20230723_1508433.jpg fill";
        #};
      };
      startup = [
        #{ command = "dbus-update-activation-environment --all"; }
        { command = "/usr/libexec/polkit-gnome-authentication-agent-1"; }
        { command = "/lib64/libexec/pam_kwallet_init"; }
        { command = "brightnessctl -d intel_backlight set 50%"; }
        { command = "sworkstyle &> /tmp/sworkstyle.log"; }
        { command = "mako"; }
      ];
      input = {
        "*" = {
          xkb_layout = "fr";
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };
      };
      keybindings = let modifier = config.wayland.windowManager.sway.config.modifier; in lib.mkOptionDefault {
        "${modifier}+Shift+c" = "kill";
        "${modifier}+Shift+r" = "reload";
        "${modifier}+Shift+e" = "exec ${pkgs.sway}/bin/swaynag -t warning -m 'Vous avez appuyé sur le raccourci de sortie. Voulez-vous vraiment quitter sway ?' -B 'Oui, quitter sway' '${pkgs.sway}/bin/swaymsg exit'";

        "${modifier}+ampersand" = "workspace number 1";
        "${modifier}+eacute" = "workspace number 2";
        "${modifier}+quotedbl" = "workspace number 3";
        "${modifier}+apostrophe" = "workspace number 4";
        "${modifier}+parenleft" = "workspace number 5";
        "${modifier}+minus" = "workspace number 6";
        "${modifier}+egrave" = "workspace number 7";
        "${modifier}+underscore" = "workspace number 8";
        "${modifier}+ccedilla" = "workspace number 9";
        "${modifier}+agrave" = "workspace number 10";

        "${modifier}+Shift+ampersand" = "move container to workspace number 1";
        "${modifier}+Shift+eacute" = "move container to workspace number 2";
        "${modifier}+Shift+quotedbl" = "move container to workspace number 3";
        "${modifier}+Shift+apostrophe" = "move container to workspace number 4";
        "${modifier}+Shift+parenleft" = "move container to workspace number 5";
        "${modifier}+Shift+minus" = "move container to workspace number 6";
        "${modifier}+Shift+egrave" = "move container to workspace number 7";
        "${modifier}+Shift+underscore" = "move container to workspace number 8";
        "${modifier}+Shift+ccedilla" = "move container to workspace number 9";
        "${modifier}+Shift+agrave" = "move container to workspace number 10";


        "${modifier}+h" = "splith";
        "${modifier}+v" = "splitv";

        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";

        "${modifier}+Shift+p" = "move scratchpad";
        "${modifier}+p" = "scratchpad show";

        "${modifier}+l" = "exec ${pkgs.swaylock}/bin/swaylock -c 282a36";

      };
      bars = [
        { command = "${pkgs.waybar}/bin/waybar"; }
      ];
    };
  };
  services.mako = {
    enable = true;
  };
  services.swayidle = {
    enable = true;
    timeouts = [
      { timeout = 30; command = "${pkgs.swaylock}/bin/swaylock -f -c 282a36"; }
      { timeout = 45; command = "${pkgs.sway}/bin/swaymsg output * power off"; resumeCommand = "${pkgs.sway}/bin/swaymsg output * power on"; }
    ];
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -f -c 282a36"; }
      { event = "lock"; command = "lock"; }
    ];
  };

  programs = {
  swaylock.enable = true;
  kitty.enable = true;
  fuzzel.enable = true;
  waybar.enable = true;

    librewolf = {
      enable = true;
      settings = { "webgl.disabled" = false; };
            package = pkgs.librewolf.override {
  # See nixpkgs' firefox/wrapper.nix to check which options you can use
  nativeMessagingHosts = [
pkgs.kdePackages.plasma-browser-integration
  ];
};
    };
#     nixvim = {
#       extraPackages = with pkgs; [ nixfmt ];
#       enable = true;
#       globals = { mapleader = " "; };
#       keymaps = [
#         {
#           mode = "n";
#           key = "<leader>ff";
#           action = "<cmd>Telescope find_files<CR>";
#           options = { desc = "Find files (Telescope)"; };
#         }
#         {
#           mode = "n";
#           key = ",D";
#           action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
#           options = { desc = "goto Declaration (LSP)"; };
#
#         }
#         {
#           mode = "n";
#           key = ",d";
#           action = "<cmd>lua vim.lsp.buf.definition()<CR>";
#           options = { desc = "goto declaration (LSP)"; };
#
#         }
#       ];
#
#       colorschemes.dracula = { enable = true; };
#       opts = {
#         number = true; # Show line numbers
#         relativenumber = true; # Show relative line numbers
#         shiftwidth = 2; # Tab width should be 2
#       };
#
#       plugins = {
#
#         # auto-save.enable = true;
#         auto-session.enable = true;
#         lualine.enable = true;
#         comment-nvim.enable = true;
#         conform-nvim = {
#           enable = true;
#           formatOnSave = "{timeout_ms = 500, lsp_fallback = true}";
#           formattersByFt = {
#             nix = [ "nixfmt" ];
#             c = [ "clang_format" ];
#           };
#         };
#         barbar.enable = true;
#         gitsigns = {
#           enable = true;
#           currentLineBlame = true;
#         };
#         clangd-extensions.enable = true;
#         # dashboard.enable = true;
#         cursorline.enable = true;
#         lsp = {
#           enable = true;
#           servers = {
#             clangd.enable = true;
#             nil_ls.enable = true;
#           };
#         };
#         lsp-lines.enable = true;
#         lspkind.enable = true;
#         cmp = { enable = true; };
#         cmp-nvim-lsp.enable = true;
#         cmp-buffer.enable = true;
#         cmp-path.enable = true;
#         cmp-cmdline.enable = true;
#         cmp-vsnip.enable = true;
#         cmp.settings.mapping = {
#           "<C-Space>" = "cmp.mapping.complete()";
#           "<C-d>" = "cmp.mapping.scroll_docs(-4)";
#           "<C-e>" = "cmp.mapping.close()";
#           "<C-f>" = "cmp.mapping.scroll_docs(4)";
#           "<CR>" = "cmp.mapping.confirm({ select = true })";
#           "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
#           "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
#         };
#         lsp-format.enable = true;
#         navbuddy = {
#           enable = true;
#           lsp.autoAttach = true;
#         };
#         navic = {
#           enable = true;
#           lsp.autoAttach = true;
#         };
#         neo-tree.enable = true;
#         nix.enable = true;
#         nvim-colorizer.enable = true;
#         # project-nvim.enable = true;
#         rainbow-delimiters.enable = true;
#
#         # };
#         telescope = {
#           enable = true;
#           extensions = {
#             #file_browser = { enable = true; };
#             # frecency = {
#             #   enable = true;
#             # };
#             # fzf-native.enable = true;
#             # fzy-native.enable = true;
#             # media_files.enable = true;
#             # project-nvim.enable = true;
#             undo.enable = true;
#           };
#         };
#         todo-comments.enable = true;
#         treesitter = { enable = true; };
#         treesitter-context.enable = true;
#         treesitter-refactor.enable = true;
#         treesitter-textobjects.enable = true;
#         which-key = {
#           enable = true;
#           registrations = { "<leader>f" = "Find"; };
#         };
#       };
#     };

    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
        os = { disabled = false; };
        sudo = { disabled = false; };
        directory = {
          truncation_length = 5;
          #fish_style_pwd_dir_length = 5;
          truncate_to_repo = true;
        };
        username = { show_always = false; };
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ls =
          "eza --icons --group-directories-first --git -@ --git-repos --header --group --created --modified";
        ll = "ls -l";
        la = "ls -la";
        l = "ls";
        update =
          "sudo nixos-rebuild boot --flake ~/Documents/nixos/#loicdm-pcp --upgrade-all";
        ip = "ip --color";
      };
      initExtra = ''
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
        # active. Only then are the values from $terminfo valid.
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
