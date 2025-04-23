-- Set up leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic settings
vim.opt.number = true           -- Line numbers
vim.opt.relativenumber = true   -- Relative line numbers
vim.opt.shiftwidth = 2          -- Size of an indent
vim.opt.tabstop = 2             -- Number of spaces tabs count for
vim.opt.expandtab = true        -- Use spaces instead of tabs
vim.opt.smartindent = true      -- Insert indents automatically
vim.opt.termguicolors = true    -- True color support
vim.opt.ignorecase = true       -- Ignore case in search
vim.opt.smartcase = true        -- Don't ignore case with capitals
vim.opt.updatetime = 250        -- Faster update time
vim.opt.clipboard = "unnamedplus" -- Use system clipboard

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set up plugins
require("lazy").setup({
  -- Add Telescope for searching
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      -- Configure Telescope
      require('telescope').setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git" },
        }
      })
      
      -- Keymaps
      vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files)
      vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep)
      vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers)
    end
  },
  
  -- Add a colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd[[colorscheme tokyonight-moon]]
    end,
  },
})
