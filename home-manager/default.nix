{ pkgs, nixvim, ... }:
{
  imports = [
    nixvim.homeManagerModules.nixvim
  ];
  
  home = {
    username = "sperrault";
    homeDirectory = "/Users/sperrault";
    stateVersion = "24.11";

    sessionVariables = {
      SSH_AUTH_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };

    packages = with pkgs; [
      watchman
      difftastic
    ];
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
    '';
    shellAbbrs = {
      j = "jj";
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.direnv.enable = true;

  programs.mise = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.nixvim = {
    enable = true;

    globals = {
      mapleader = " ";
    };

    globalOpts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      expandtab = true;
      tabstop = 2;
    };

    colorschemes.catppuccin.enable = true;

    keymaps = [
      {
        key = ";";
        action = ":";
        mode = ["n" "v"];
      }
      {
        key = "<leader>y";
        action = ''"+y'';
        mode = ["n" "v"];
      }
      {
        key = "<leader>Y";
        action = ''"+Y'';
        mode = ["n" "v"];
      }
      {
        key = "<leader>p";
        action = ''"+p'';
        mode = ["n" "v"];
      }
      {
        key = "<leader>P";
        action = ''"+P'';
        mode = ["n" "v"];
      }
      {
        key = "<leader>w";
        action = "<cmd>w<cr>";
        mode = ["n"];
      }
      {
        key = "<leader>q";
        action = "<cmd>q<cr>";
        mode = ["n"];
      }
      {
        key = "<esc>";
        action = "<cmd>nohlsearch<cr>";
        mode = ["n"];
      }
      {
        key = ''<leader>"'';
        action = "<cmd>split<cr>";
        mode = ["n"];
      }
      {
        key = "<leader>%";
        action = "<cmd>vsplit<cr>";
        mode = ["n"];
      }
      {
        key = "<leader><tab>";
        action = "<cmd>NERDTreeToggle<cr>";
        mode = ["n"];
      }
      {
        key = "<leader>fl";
        action = "<cmd>NERDTreeFind<cr>";
        mode = ["n"];
      }
      {
        key = "<leader><space>";
        action = "<cmd>Telescope find_files theme=dropdown<cr>";
        mode = ["n"];
      }
      {
        key = "<leader>/";
        action = "<cmd>Telescope live_grep<cr>";
        mode = ["n"];
      }
    ];

    extraPlugins = with pkgs.vimPlugins; [
      vim-abolish
      nerdtree
      vim-rhubarb
    ];

    plugins.commentary.enable = true;
    plugins.repeat.enable = true;
    plugins.fugitive.enable = true;

    plugins.nvim-autopairs.enable = true;
    plugins.nvim-surround.enable = true;

    plugins.web-devicons.enable = true;

    plugins.treesitter = {
      enable = true;
      settings.indent.enable = true;
      settings.highlight.enable = true;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        json
        lua
        markdown
        nix
        toml
        vim
        yaml
        elixir
        javascript
        typescript
        css
        html
      ];
    };

    plugins.lsp = {
      enable = true;
      servers = {
        elixirls.enable = true;
        fish_lsp.enable = true;
        html.enable = true;
        nixd.enable = true;
        tailwindcss.enable = true;
        terraform_lsp.enable = true;
      };
    };

    plugins.telescope.enable = true;

    plugins.cmp = {
      enable = true;
      autoEnableSources = true;
      settings.sources = [
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "path"; }
        { name = "buffer"; }
      ];
    };
  };

  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        extraOptions.IdentityAgent = ''"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
      };
    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      core.fsmonitor = "watchman";
      user = {
        name = "sloane";
        email = "git@sloanelybutsurely.com";
      };
      signing = {
        sign-all = true;
        backend = "ssh";
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID0TH2GezEx8+zlKBqUb7rBsbmghnd1u4nX6YpQr28Zw";
        backends.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };
      ui = {
        paginate = "never";
        default-command = "log";
        editor = "nvim";
        diff.tool = ["difft" "--color=always" "$left" "$right"];
      };
      revsets.log = "trunk() | ancestors(reachable(@ | mine(), mutable()), 2) | @";
      git = {
        push-bookmark-prefix = "sloane/push-";
        private-commits = "wip | nocommit | dev-only";
      };
      revset-aliases = {
        wip = ''description(regex:"^\\[(wip|WIP|todo|TODO)\\]|(wip|WIP|todo|TODO):?")'';
        nocommit = ''description(regex:"^\\[(nocommit|NOCOMMIT)\\]|(nocommit|NOCOMMIT):?")'';
        dev-only = ''description(regex:"^\\[(dev-only|DEV-ONLY)\\]|(dev-only|DEV-ONLY):?")'';
        current = ''(bookmarks() | wip | dev-only) & mine()'';
      };
    };
  };
}
