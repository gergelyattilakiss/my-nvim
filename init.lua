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
  { "github/copilot.vim" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      "github/copilot.vim",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      -- Optional configuration here
      show_help = "yes", -- Show help text for CopilotChatInPlace
      prompts = {
        Explain = "Explain how this code works, in detail.",
        Review = "Review this code and suggest improvements.",
        Tests = "Generate unit tests for this code.",
        Fix = "What's wrong with this code and how can I fix it?",
      },
    },
    -- Optional custom configuration
    config = function(_, opts)
      require("CopilotChat").setup(opts)
      
      -- Set up some keymaps
      vim.keymap.set("n", "<leader>cc", ":CopilotChat ", { desc = "CopilotChat - Ask a question" })
      vim.keymap.set("v", "<leader>ce", ":CopilotChatExplain<cr>", { desc = "CopilotChat - Explain code" })
      vim.keymap.set("v", "<leader>ct", ":CopilotChatTests<cr>", { desc = "CopilotChat - Generate tests" })
      vim.keymap.set("v", "<leader>cr", ":CopilotChatReview<cr>", { desc = "CopilotChat - Review code" })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
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
