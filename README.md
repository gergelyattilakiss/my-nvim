# My Neovim Configuration

A portable, feature-rich Neovim configuration optimized for remote development with Python, Julia, Stata, SQL, and Rust. Includes tmux integration and flexible AI assistance.

## ✨ Features

- **Language Support**: Python, Julia, Rust, SQL/DuckDB, Stata, Lua, Bash
- **LSP Integration**: Auto-completion, diagnostics, go-to-definition
- **AI Assistant**: Flexible AI with easy model switching (Anthropic, OpenAI, Ollama)
- **Tmux Integration**: Seamless navigation between Neovim and tmux panes
- **Git Integration**: GitSigns for hunks, LazyGit for full UI
- **File Explorer**: nvim-tree for project navigation
- **Fuzzy Finding**: Telescope for files, text, and more
- **Beautiful UI**: Tokyo Night theme, Lualine status line, bufferline

## 🚀 Quick Install

### Automated Installation

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/my-nvim/main/install.sh | bash
```

### Manual Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this repo
git clone https://github.com/YOUR_USERNAME/my-nvim.git ~/.config/nvim

# Start Neovim (plugins will auto-install)
nvim
```

## 📋 Prerequisites

### Required
- Neovim >= 0.9.0
- Git
- A Nerd Font (for icons)

### Recommended
- ripgrep (for telescope live grep)
- fd (for telescope find files)
- lazygit (for git UI)
- tmux (for terminal multiplexing)

### Language Servers (installed automatically)

```bash
# Python
pip install pyright black isort ruff

# Julia
# Install LanguageServer.jl in Julia REPL:
# using Pkg; Pkg.add("LanguageServer")

# Rust
rustup component add rust-analyzer rustfmt clippy

# SQL
# sqls will be installed via Mason

# Lua
# lua-language-server will be installed via Mason
```

## 🔑 AI Configuration

1. Copy the example environment file:
```bash
cp ~/.config/nvim/.env.example ~/.config/nvim/.env
```

2. Edit `.env` and add your API keys:
```bash
export ANTHROPIC_API_KEY="your-anthropic-key"
export OPENAI_API_KEY="your-openai-key"
```

3. Source the file (add to your `~/.bashrc` or `~/.zshrc`):
```bash
source ~/.config/nvim/.env
```

4. Change the default AI provider in `lua/plugins/ai.lua`:
```lua
strategies = {
  chat = {
    adapter = "anthropic", -- or "openai", "ollama"
  },
},
```

## 🎯 Key Mappings

Leader key: `<Space>`

### General
| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate splits (works with tmux!) |
| `<S-h/l>` | Previous/Next buffer |
| `<leader>q` | Quit |
| `<leader>bd` | Delete buffer |
| `<C-\>` | Toggle terminal |

### File Explorer
| Key | Action |
|-----|--------|
| `<leader>ee` | Toggle file explorer |
| `<leader>ef` | Find file in explorer |
| `<leader>ec` | Collapse folders |

### Telescope (Find)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search text) |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Help tags |
| `<leader>fr` | Recent files |
| `<leader>fk` | Find keymaps |
| `<leader>ft` | Find TODOs |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename |
| `[d` / `]d` | Previous/Next diagnostic |
| `<leader>cf` | Format code |

### Git
| Key | Action |
|-----|--------|
| `<leader>gg` | Open LazyGit |
| `<leader>hp` | Preview hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hb` | Blame line |
| `[h` / `]h` | Previous/Next hunk |

### AI Assistant
| Key | Action |
|-----|--------|
| `<leader>aa` | AI actions menu |
| `<leader>ac` | Toggle AI chat |
| `<leader>ai` | Inline AI prompt |
| `<leader>ae` | Explain code |
| `<leader>af` | Fix code |
| `<leader>ao` | Optimize code |
| `<leader>ad` | Add documentation |

## 🔧 Customization

### Change Colorscheme

Edit `lua/plugins/colorscheme.lua`:
```lua
vim.cmd([[colorscheme tokyonight-moon]])
-- Options: tokyonight-moon, tokyonight-storm, tokyonight-night
```

### Add More Languages

Edit `lua/plugins/lsp.lua` and add your language server:
```lua
lspconfig["your_lsp"].setup({
  capabilities = capabilities,
})
```

### Modify Keybindings

Edit `lua/config/keymaps.lua` to change any keybinding.

### Change AI Model

Edit `lua/plugins/ai.lua`:
```lua
schema = {
  model = {
    default = "claude-sonnet-4-20250514", -- Change this
  },
},
```

## 📁 Directory Structure

```
~/.config/nvim/
├── init.lua                  # Entry point
├── lua/
│   ├── config/
│   │   ├── options.lua       # Vim options
│   │   ├── keymaps.lua       # Key mappings
│   │   └── autocmds.lua      # Auto commands
│   └── plugins/
│       ├── ai.lua            # AI assistant
│       ├── cmp.lua           # Completion
│       ├── colorscheme.lua   # Theme
│       ├── formatting.lua    # Code formatting
│       ├── git.lua           # Git integration
│       ├── lsp.lua           # Language servers
│       ├── lualine.lua       # Status line
│       ├── nvim-tree.lua     # File explorer
│       ├── telescope.lua     # Fuzzy finder
│       ├── tmux-navigator.lua # Tmux integration
│       ├── treesitter.lua    # Syntax highlighting
│       └── utils.lua         # Utility plugins
├── install.sh                # Installation script
└── README.md                 # This file
```

## 🌐 Remote Server Setup

### Via SSH
```bash
ssh user@remote-server
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/my-nvim/main/install.sh | bash
```

### Tmux Integration

Add to your `~/.tmux.conf`:
```bash
# Smart pane switching with awareness of Vim splits
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
```

Then reload: `tmux source-file ~/.tmux.conf`

## 🐛 Troubleshooting

### Plugins not installing
```bash
nvim
:Lazy sync
```

### LSP not working
```bash
:LspInfo          # Check LSP status
:Mason            # Install language servers
```

### Python LSP issues
```bash
pip install --upgrade pyright
```

### Julia LSP issues
In Julia REPL:
```julia
using Pkg
Pkg.add("LanguageServer")
Pkg.update()
```

## 📚 Resources

- [Neovim Docs](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [LSP Config](https://github.com/neovim/nvim-lspconfig)
- [CodeCompanion](https://github.com/olimorris/codecompanion.nvim)

## 🤝 Contributing

Feel free to fork and customize this config for your needs!

## 📝 License

MIT
