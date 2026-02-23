return {
  "olimorris/codecompanion.nvim",
  keys = {
    { "<leader><leader>c", mode = { "n", "v" } },
    { "<leader><leader>a", mode = { "n", "v" } },
    { "<leader><leader>e", mode = { "n", "v" } },
    { "<leader><leader>f", mode = { "n", "v" } },
  },
  cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "github/copilot.vim",
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
          adapter = "copilot", -- Using GitHub Copilot. Change to "anthropic", "openai", or "ollama"
        },
        inline = {
          adapter = "copilot",
        },
        agent = {
          adapter = "copilot",
        },
      },
      prompt_library = {
        ["explain"] = {
          strategy = "chat",
          description = "Explain how the selected code works",
          prompts = {
            {
              role = "system",
              content = "You are an expert programmer. Explain code clearly and concisely.",
            },
            {
              role = "user",
              content = function(context)
                local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                return string.format(
                  "Please explain how this %s code works:\n\n```%s\n%s\n```",
                  context.filetype,
                  context.filetype,
                  code
                )
              end,
            },
          },
        },
        ["fix"] = {
          strategy = "chat",
          description = "Fix issues in the selected code",
          prompts = {
            {
              role = "system",
              content = "You are an expert programmer. Fix bugs and issues in code.",
            },
            {
              role = "user",
              content = function(context)
                local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                return string.format(
                  "Please review this %s code and fix any issues:\n\n```%s\n%s\n```",
                  context.filetype,
                  context.filetype,
                  code
                )
              end,
            },
          },
        },
        ["optimize"] = {
          strategy = "chat",
          description = "Optimize the selected code",
          prompts = {
            {
              role = "system",
              content = "You are an expert programmer. Optimize code for performance and readability.",
            },
            {
              role = "user",
              content = function(context)
                local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                return string.format(
                  "Please optimize this %s code:\n\n```%s\n%s\n```",
                  context.filetype,
                  context.filetype,
                  code
                )
              end,
            },
          },
        },
        ["docstring"] = {
          strategy = "inline",
          description = "Add documentation to the code",
          prompts = {
            {
              role = "system",
              content = "You are an expert at writing clear, concise documentation.",
            },
            {
              role = "user",
              content = function(context)
                local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                return string.format(
                  "Add appropriate documentation/docstring to this %s code:\n\n```%s\n%s\n```\n\nReturn ONLY the code with added documentation, no explanations.",
                  context.filetype,
                  context.filetype,
                  code
                )
              end,
            },
          },
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

    -- Keymaps - Using double-space (easy on any keyboard layout)
    local keymap = vim.keymap.set

    -- Main AI commands (Space Space + letter)
    keymap({ "n", "v" }, "<leader><leader>c", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "AI: Toggle Chat" })
    keymap({ "n", "v" }, "<leader><leader>a", "<cmd>CodeCompanionActions<cr>", { desc = "AI: Actions Menu" })
    keymap("v", "<leader><leader>v", "<cmd>CodeCompanionChat Add<cr>", { desc = "AI: Add selection to chat" })
    -- Quick prompts - work in both normal and visual mode
    -- In normal mode: uses current line or function under cursor
    -- In visual mode: uses selected text
    keymap({ "n", "v" }, "<leader><leader>e", function()
      require("codecompanion").prompt("explain")
    end, { desc = "AI: Explain code" })

    keymap({ "n", "v" }, "<leader><leader>f", function()
      require("codecompanion").prompt("fix")
    end, { desc = "AI: Fix code" })

    keymap({ "n", "v" }, "<leader><leader>o", function()
      require("codecompanion").prompt("optimize")
    end, { desc = "AI: Optimize code" })

    keymap({ "n", "v" }, "<leader><leader>d", function()
      require("codecompanion").prompt("docstring")
    end, { desc = "AI: Add documentation" })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])
  end,
}
