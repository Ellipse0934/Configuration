{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = ''
      vim.opt.relativenumber = true

      vim.opt.tabstop = 4
      vim.opt.softtabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true

      vim.opt.smartindent = true
      vim.opt.colorcolumn = "80"

      local colorscheme = "gruvbox"
      pcall(vim.cmd, "colorscheme " .. colorscheme)

      require'nvim-treesitter.configs'.setup {
        highlight = {
            enable = true;
        }
      }
    '';
    extraPackages = with pkgs; [ tree-sitter ];
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter
      nvim-treesitter-parsers.julia
      nvim-treesitter-parsers.cpp
      gruvbox
    ];
  };
}
