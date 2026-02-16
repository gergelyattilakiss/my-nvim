return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local keymap = vim.keymap.set

        -- Navigation
        keymap("n", "]h", gs.next_hunk, { buffer = bufnr, desc = "Next Hunk" })
        keymap("n", "[h", gs.prev_hunk, { buffer = bufnr, desc = "Prev Hunk" })

        -- Actions
        keymap("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
        keymap("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
        keymap("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { buffer = bufnr, desc = "Stage hunk" })
        keymap("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { buffer = bufnr, desc = "Reset hunk" })

        keymap("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr, desc = "Stage buffer" })
        keymap("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr, desc = "Reset buffer" })

        keymap("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })

        keymap("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })

        keymap("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, { buffer = bufnr, desc = "Blame line" })
        keymap("n", "<leader>hB", gs.toggle_current_line_blame, { buffer = bufnr, desc = "Toggle line blame" })

        keymap("n", "<leader>hd", gs.diffthis, { buffer = bufnr, desc = "Diff this" })
        keymap("n", "<leader>hD", function()
          gs.diffthis("~")
        end, { buffer = bufnr, desc = "Diff this ~" })
      end,
    },
  },

  -- Lazygit integration
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
}
