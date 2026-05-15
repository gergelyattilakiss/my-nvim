return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      python = { "ruff" },
      lua = { "selene" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      yaml = { "yamllint" },
      json = { "jsonlint" },
      markdown = { "markdownlint" },
      sql = { "sqlfluff" },
      -- julia = {"julialint"}, -- not available in nvim-lint
      rust = {"clippy"},

    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>cl", function()
      lint.try_lint()
    end, { desc = "Lint current buffer" })
  end,
}
