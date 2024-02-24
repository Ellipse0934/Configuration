{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = ''--lua
      vim.opt.relativenumber = true
      vim.opt.clipboard = "unnamed,unnamedplus"

      vim.opt.tabstop = 4
      vim.opt.softtabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true

      vim.opt.textwidth = 80
      vim.opt.smartindent = true
      vim.opt.colorcolumn = "80"
      vim.opt.wrapmargin = 0

      local colorscheme = "gruvbox"
      pcall(vim.cmd, "colorscheme " .. colorscheme)
  
      require'nvim-treesitter.configs'.setup {
        highlight = {
            enable = true;
        }
      }
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      
      require('lualine').setup()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    '';
    extraPackages = with pkgs; [
        tree-sitter
    ];

    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      lualine-nvim
      nvim-treesitter
      playground
      image-nvim
      nvim-treesitter-parsers.markdown
      nvim-treesitter-parsers.ruby
      nvim-treesitter-parsers.bash
      nvim-treesitter-parsers.sql
      nvim-treesitter-parsers.json
      nvim-treesitter-parsers.julia
      nvim-treesitter-parsers.cpp
      nvim-treesitter-parsers.vim
      nvim-treesitter-parsers.vimdoc
      gruvbox
    ];
  };
}
