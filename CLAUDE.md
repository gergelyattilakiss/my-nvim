# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A portable Neovim configuration for remote server development. Languages: Python, Julia, Stata, SQL/DuckDB, Rust. Includes tmux integration and AI assistance via CodeCompanion.

## Verification Commands

```bash
# Test config loads without errors
nvim --headless "+qa"

# Check plugin health
nvim --headless "+checkhealth" "+qa"

# Sync plugins after changes
nvim --headless "+Lazy sync" "+qa"
```

## Architecture

- `init.lua` — Entry point. Bootstraps lazy.nvim, loads `config/` modules, then sets up all plugins from `lua/plugins/`.
- `lua/config/` — Core settings: `options.lua`, `keymaps.lua`, `autocmds.lua`. Loaded before plugins.
- `lua/plugins/` — One file per plugin. Lazy.nvim auto-discovers all `.lua` files in this directory. To disable a plugin, rename its file to `.lua.disabled`.

All plugins default to `lazy = true` (set in `init.lua`). Each plugin file must specify its own load triggers (`event`, `keys`, `cmd`).

## Key Design Constraints

**Hungarian QWERTZ keyboard**: User cannot easily reach `\`, `|`, or other special symbols. Always use letter combinations for keybindings (e.g., `<leader>f`, `<leader><leader>c`). Never use `<leader>\` or similar.

**AI keybindings use `<leader><leader>` (double-space)**: This was chosen because single `<leader>` + letter triggers Vim commands on Hungarian layout. Do not change this prefix.

**Remote/SSH focus**: No GUI dependencies. Terminal-only. Startup must stay fast via lazy loading.

**Neovim version**: Currently uses 0.11+ APIs (`vim.lsp.config[]` / `vim.lsp.enable()`). The old `setup_lsp()` compatibility shim for 0.9 was removed — LSP config in `lsp.lua` now uses the new API directly.

## LSP Setup Pattern

In `lua/plugins/lsp.lua`, language servers are configured with:
```lua
vim.lsp.config["server_name"] = { capabilities = capabilities, settings = { ... } }
vim.lsp.enable("server_name")
```

**Bug**: Line 150 has `vim.lsp.enable("sqls")` which should be `vim.lsp.enable("lua_ls")`.

Mason (`mason.nvim` + `mason-lspconfig.nvim`) auto-installs most servers. Exceptions requiring manual install: `rust_analyzer` (via rustup), `julials` (via Julia Pkg), `sqls` (Mason UI).

## Adding a New Plugin

1. Create `lua/plugins/your-plugin.lua` returning a lazy.nvim plugin spec
2. Include appropriate lazy-load triggers (`event`, `keys`, or `cmd`)
3. Define keymaps inside the plugin's `config` function
4. Restart Neovim — lazy.nvim picks it up automatically

## Adding a New Language Server

1. Add the server name to Mason's `ensure_installed` list in `lua/plugins/lsp.lua`
2. Add `vim.lsp.config["server"]` + `vim.lsp.enable("server")` in the same file
3. Add the treesitter parser to `ensure_installed` in `lua/plugins/treesitter.lua`
4. If it needs a formatter, add it to `formatters_by_ft` in `lua/plugins/formatting.lua`

## AI (CodeCompanion)

Configured in `lua/plugins/ai.lua`. Uses Anthropic (Claude) by default. Change adapter in `strategies.chat.adapter` to `"openai"` or `"ollama"`. API keys come from environment variables (`ANTHROPIC_API_KEY`, `OPENAI_API_KEY`).

## Leader Key

Leader is Space. Key groups:
- `<leader>f` — Telescope (find files, grep)
- `<leader>e` — File explorer / diagnostics
- `<leader>s` — Splits
- `<leader>c` — Code actions, formatting
- `<leader>h` — Git hunks
- `<leader>g` — Git (LazyGit)
- `<leader><leader>` — AI commands (CodeCompanion)
