{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;

    globals = {
      mapleader = " ";
    };

    opts = {
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
        key = "q;";
        action = "q:";
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
      {
        key = "<C-h>";
        action = "<cmd>ZellijNavigateLeft<cr>";
        mode = ["n"];
      }
      {
        key = "<C-j>";
        action = "<cmd>ZellijNavigateDown<cr>";
        mode = ["n"];
      }
      {
        key = "<C-k>";
        action = "<cmd>ZellijNavigateUp<cr>";
        mode = ["n"];
      }
      {
        key = "<C-l>";
        action = "<cmd>ZellijNavigateRight<cr>";
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
        heex
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
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "snippy"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        mappings = {
          "<C-n>" = ''
            function(fallback) do
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
              else
                fallback()
              end
            end
          '';
          "<C-p>" = ''
            function(fallback) do
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
              else
                fallback()
              end
            end
          '';
          "<CR>" = ''
            function(fallback)
              if cmp.visible() then
                cmp.confirm({ select = true })
              else
                fallback()
              end
            end
          '';
        };
        snippet.expand = ''
          function(args)
            require('snippy').expand_snippet(args.body)
          end
        '';
      };
    };

    plugins.zellij-nav.enable = true;
  };
}
