return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap.set

    -- LSP keybindings
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "Show LSP references"
        keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"
        keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        keymap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        keymap("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        keymap("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Show documentation for what is under cursor"
        keymap("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    -- Enhanced capabilities
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Diagnostic signs
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Configure diagnostic display
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
      },
      signs = true,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- Python
    vim.lsp.config["pyright"] = {
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          },
        },
      },
    }
    vim.lsp.enable("pyright")

    -- Julia
    vim.lsp.config["julials"] = {
      capabilities = capabilities,
    }
    vim.lsp.enable("julials")

    -- Rust
    vim.lsp.config["rust_analyzer"] = {
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy",
          },
          cargo = {
            allFeatures = true,
          },
        },
      },
    }
    vim.lsp.enable("rust-analyzer")

    -- SQL (sqls)
    vim.lsp.config["sqls"] = {
      capabilities = capabilities,
    }
    vim.lsp.enable("sqls")

    -- Lua
    vim.lsp.config["lua_ls"] = {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    }
    vim.lsp.enable("sqls")

    -- Bash
    vim.lsp.config["bashls"] = {
      capabilities = capabilities,
    }
    vim.lsp.enable("bashls")

    -- YAML
    vim.lsp.config["yamlls"] = {
      capabilities = capabilities,
    }
    vim.lsp.enable("yamlls")

    -- JSON
    vim.lsp.config["jsonls"] = {
      capabilities = capabilities,
    }
    vim.lsp.enable("jsonls")
  end,
}
