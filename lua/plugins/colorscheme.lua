return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "moon",
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
        },
      })
      vim.cmd([[colorscheme tokyonight-moon]])
    end,
  },

  -- Alternative colorschemes (uncomment to try)
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- { "rebelot/kanagawa.nvim", priority = 1000 },
}
