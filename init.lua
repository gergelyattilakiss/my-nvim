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
  { "nvim-lua/plenary.nvim" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  {
    "baruchel/vim-notebook",
    init = function()
      --Keymaps
      vim.keymap.set('n', '<F5>', '<cmd>NotebookConvertIPynb<CR>', { noremap = true, silent = true })
      vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufReadPost' }, {pattern = '*.ipynb',command = 'set filetype=vim-notebook'})
      vim.keymap.set('n', '<leader>s', '<cmd>NotebookSave<CR>', { noremap = true, silent = true })
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
 

  require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all" (parsers with maintainers)
  ensure_installed = { "lua", "vim", "vimdoc", "python", "javascript", "typescript", "c", "rust", "r", "julia", "markdown", "fish", "bash", "yaml", "toml", "json",}, 

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    -- Enable syntax highlighting
    enable = true,
    
    -- Disable treesitter highlight for large files
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },

  -- Enable indentation based on treesitter
  indent = { enable = true },
  
  -- Enable incremental selection based on the named nodes from the grammar
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
