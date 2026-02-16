return {
  "olimorris/codecompanion.nvim",
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
    keymap({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "AI Actions" })
    keymap({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle AI Chat" })
    keymap("v", "<leader>ae", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add selection to chat" })
    keymap("n", "<leader>ai", "<cmd>CodeCompanion<cr>", { desc = "Inline AI prompt" })
    
    -- Quick prompts
    keymap("n", "<leader>ae", function()
      require("codecompanion").prompt("explain")
    end, { desc = "Explain code" })
    
    keymap("n", "<leader>af", function()
      require("codecompanion").prompt("fix")
    end, { desc = "Fix code" })
    
    keymap("n", "<leader>ao", function()
      require("codecompanion").prompt("optimize")
    end, { desc = "Optimize code" })
    
    keymap("n", "<leader>ad", function()
      require("codecompanion").prompt("docstring")
    end, { desc = "Add documentation" })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])
  end,
}
