return {
  "olimorris/codecompanion.nvim",
  keys = {
    { "<leader><leader>c", mode = { "n", "v" } },
    { "<leader><leader>a", mode = { "n", "v" } },
    { "<leader><leader>e", mode = "n" },
    { "<leader><leader>f", mode = "n" },
    { "<leader><leader>i", mode = "n" },
  },
  cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    {
      "stevearc/dressing.nvim",
      opts = {},
    },
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "ANTHROPIC_API_KEY",
            },
            schema = {
              model = {
                default = "claude-sonnet-4-20250514",
              },
            },
          })
        end,
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = "OPENAI_API_KEY",
            },
            schema = {
              model = {
                default = "gpt-4o",
              },
            },
          })
        end,
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "codellama:latest",
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "anthropic", -- Change to "openai", "ollama", or any other adapter
        },
        inline = {
          adapter = "anthropic",
        },
        agent = {
          adapter = "anthropic",
        },
      },
      display = {
        chat = {
          window = {
            layout = "vertical", -- float|vertical|horizontal|buffer
            width = 0.45,
            height = 0.8,
            relative = "editor",
            border = "rounded",
          },
          intro_message = "Welcome! I'm here to help with your code.",
        },
      },
    })

    -- Keymaps
    local keymap = vim.keymap.set
    -- Main AI commands (using comma prefix - completely safe)
    keymap({ "n", "v" }, "<leader><leader>c", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "AI: Toggle Chat" })
    keymap({ "n", "v" }, "<leader><leader>a", "<cmd>CodeCompanionActions<cr>", { desc = "AI: Actions Menu" })
    keymap("v", "<leader><leader>v", "<cmd>CodeCompanionChat Add<cr>", { desc = "AI: Add selection to chat" })
    keymap("n", "<leader><leader>i", "<cmd>CodeCompanion<cr>", { desc = "AI: Inline prompt" })

    -- Quick prompts (using comma prefix)
    keymap("n", "<leader><leader>e", function()
      require("codecompanion").prompt("explain")
    end, { desc = "AI: Explain code" })

    keymap("n", "<leader><leader>f", function()
      require("codecompanion").prompt("fix")
    end, { desc = "AI: Fix code" })

    keymap("n", "<leader><leader>o", function()
      require("codecompanion").prompt("optimize")
    end, { desc = "AI: Optimize code" })

    keymap("n", "<leader><leader>d", function()
      require("codecompanion").prompt("docstring")
    end, { desc = "AI: Add documentation" })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])
  end,
}
