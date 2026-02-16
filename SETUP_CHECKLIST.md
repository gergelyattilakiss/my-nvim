# First-Time Setup Checklist

Use this checklist when setting up on a new server.

## Pre-Installation

- [ ] Neovim 0.9+ installed (`nvim --version`)
- [ ] Git installed (`git --version`)
- [ ] Internet connection available
- [ ] Have your API keys ready (optional, for AI features)

## Installation

- [ ] Run install script OR manually clone repo
  ```bash
  curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/my-nvim/main/install.sh | bash
  ```
- [ ] Create `.env` file with API keys (if using AI)
  ```bash
  cp ~/.config/nvim/.env.example ~/.config/nvim/.env
  nano ~/.config/nvim/.env
  ```
- [ ] Source environment file
  ```bash
  echo 'source ~/.config/nvim/.env' >> ~/.bashrc
  source ~/.bashrc
  ```

## First Launch

- [ ] Start Neovim: `nvim`
- [ ] Wait for lazy.nvim to install plugins (1-2 minutes)
- [ ] Quit (`:q`) and restart
- [ ] Run health check: `:checkhealth`
- [ ] Review any warnings/errors

## Language Setup

### Python
- [ ] Install pyright: `pip install pyright`
- [ ] Install formatters: `pip install black isort ruff`
- [ ] Test: Open a `.py` file, hover over function should show docs

### Julia
- [ ] Install LanguageServer in Julia REPL:
  ```julia
  using Pkg
  Pkg.add("LanguageServer")
  ```
- [ ] Test: Open a `.jl` file, LSP should start (check `:LspInfo`)

### Rust (if using)
- [ ] Install components: `rustup component add rust-analyzer rustfmt clippy`
- [ ] Test: Open `.rs` file, should have completion

### SQL (if using)
- [ ] Open Neovim, run `:Mason`
- [ ] Search for `sqls`, press `i` to install
- [ ] Configure connection in `~/.config/sqls/config.yml`

## Optional Tools

- [ ] Install ripgrep: `sudo apt install ripgrep` (for better search)
- [ ] Install fd: `sudo apt install fd-find` (for better file finding)
- [ ] Install lazygit: [Installation guide](https://github.com/jesseduffield/lazygit)
- [ ] Setup tmux (see REMOTE_WORKFLOW.md)

## Tmux Setup (if using)

- [ ] Install tmux: `sudo apt install tmux`
- [ ] Add navigation config to `~/.tmux.conf` (see REMOTE_WORKFLOW.md)
- [ ] Test: Create tmux session, test `Ctrl-h/j/k/l` navigation

## Verification

- [ ] Open a project file
- [ ] Try `Space ff` (find files) - should work
- [ ] Try `gd` on a function - should jump to definition
- [ ] Try `K` on a function - should show docs
- [ ] Try `Space cf` - should format file
- [ ] Try `Space ac` - should open AI chat (if configured)
- [ ] Try `Space gg` - should open LazyGit (if installed)

## Common Issues

### Plugins didn't install
```vim
:Lazy
# Press 'S' to sync
```

### LSP not working
```vim
:LspInfo
# Check if server is attached
:Mason
# Install missing servers
```

### Formatters not found
```bash
# Check installation
which black
which rustfmt

# Install if missing
pip install black
```

### Telescope finds nothing
```bash
# Install better tools
sudo apt install ripgrep fd-find
```

## Customization (Optional)

- [ ] Change colorscheme in `lua/plugins/colorscheme.lua`
- [ ] Adjust keymaps in `lua/config/keymaps.lua`
- [ ] Change AI model in `lua/plugins/ai.lua`
- [ ] Add language servers in `lua/plugins/lsp.lua`

## Next Steps

1. Read CHEATSHEET.md for keyboard shortcuts
2. Read LANGUAGE_SETUP.md for language-specific tips
3. Read REMOTE_WORKFLOW.md for tmux workflows
4. Start coding! 🚀

## Getting Help

- `:help` - Neovim help
- `:checkhealth` - System diagnostics
- `:Mason` - Language server manager
- `:Lazy` - Plugin manager
- `Space fk` - Find keymaps

## Notes

Write any server-specific notes here:
- Server name: ________________
- Projects: ________________
- Special setup: ________________
