return {
  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- Surround text objects
  {
    "kylechui/nvim-surround",
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
    config = true,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },

  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = {
        char = "│",
      },
    },
  },

  -- Highlight TODO comments
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup()
      vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    end,
  },

  -- Which-key (shows keybindings)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    config = function()
      local wk = require("which-key")
      wk.setup()

      -- Register key groups
      wk.add({
        { "<leader>f", group = "Find" },
        { "<leader>e", group = "Explorer" },
        { "<leader>s", group = "Split" },
        { "<leader>h", group = "Git Hunk" },
        { "<leader>g", group = "Git" },
        { "<leader><leader>", group = "AI Assistant" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Diagnostics" },
        { "<leader>r", group = "Rename/Restart" },
      })
    end,
  },

  -- Better UI components
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },

  -- Buffer line (tabs)
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    opts = {
      options = {
        mode = "buffers",
        separator_style = "slant",
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,
      },
    },
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
    },
  },
}
