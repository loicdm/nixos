{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "root";
  home.homeDirectory = "/root";
  home.packages = with pkgs; [ ];

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  programs = {
    nixvim = {
      extraPackages = with pkgs; [ nixfmt ];
      enable = true;
      globals = { mapleader = " "; };
      keymaps = [
        {
          mode = "n";
          key = "<leader>ff";
          action = "<cmd>Telescope find_files<CR>";
          options = { desc = "Find files (Telescope)"; };
        }
        {
          mode = "n";
          key = ",D";
          action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
          options = { desc = "goto Declaration (LSP)"; };

        }
        {
          mode = "n";
          key = ",d";
          action = "<cmd>lua vim.lsp.buf.definition()<CR>";
          options = { desc = "goto declaration (LSP)"; };

        }
      ];

      colorschemes.dracula = { enable = true; };
      options = {
        number = true; # Show line numbers
        relativenumber = true; # Show relative line numbers
        shiftwidth = 2; # Tab width should be 2
      };

      plugins = {
        # auto-save.enable = true;
        auto-session.enable = true;
        lualine.enable = true;
        comment-nvim.enable = true;
        conform-nvim = {
          enable = true;
          formatOnSave = "{timeout_ms = 500, lsp_fallback = true}";
          formattersByFt = {
            nix = [ "nixfmt" ];
            c = [ "clang_format" ];
          };
        };
        barbar.enable = true;
        gitsigns = {
          enable = true;
          currentLineBlame = true;
        };
        clangd-extensions.enable = true;
        # dashboard.enable = true;
        cursorline.enable = true;
        lsp = {
          enable = true;
          servers = {
            clangd.enable = true;
            nil_ls.enable = true;
          };
        };
        lsp-lines.enable = true;
        lspkind.enable = true;
        cmp = { enable = true; };
        cmp-nvim-lsp.enable = true;
        lsp-format.enable = true;
        navbuddy = {
          enable = true;
          lsp.autoAttach = true;
        };
        navic = {
          enable = true;
          lsp.autoAttach = true;
        };
        neo-tree.enable = true;
        nix.enable = true;
        nvim-colorizer.enable = true;
        # project-nvim.enable = true;
        rainbow-delimiters.enable = true;

        # };
        telescope = {
          enable = true;
          extensions = {
            file_browser = { enable = true; };
            # frecency = {
            #   enable = true;
            # };
            # fzf-native.enable = true;
            # fzy-native.enable = true;
            # media_files.enable = true;
            # project-nvim.enable = true;
            undo.enable = true;
          };
        };
        todo-comments.enable = true;
        treesitter = { enable = true; };
        treesitter-context.enable = true;
        treesitter-refactor.enable = true;
        treesitter-textobjects.enable = true;
        which-key = {
          enable = true;
          registrations = { "<leader>f" = "Find"; };
        };
      };
    };

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
