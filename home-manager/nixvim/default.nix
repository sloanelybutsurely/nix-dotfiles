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

    plugins.tmux-navigator.enable = true;
  };

}
