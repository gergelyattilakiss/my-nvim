# Neovim Cheatsheet

## Essential Commands

### Navigation (works in tmux!)
- `Ctrl-h/j/k/l` - Move between splits/tmux panes
- `Shift-h/l` - Previous/Next buffer
- `gd` - Go to definition
- `gr` - Go to references
- `Ctrl-o/i` - Jump backward/forward

### Files & Search
- `Space ff` - Find files
- `Space fg` - Search in files (live grep)
- `Space fb` - List open buffers
- `Space fr` - Recent files
- `Space ee` - Toggle file explorer

### Editing
- `gcc` - Comment line
- `gc` (visual) - Comment selection
- `ciw` - Change inner word
- `ci"` - Change inside quotes
- `vi{` - Select inside braces
- `Space cf` - Format file

### Git
- `Space gg` - Open LazyGit
- `Space hp` - Preview git hunk
- `Space hs` - Stage hunk
- `]h` / `[h` - Next/Previous hunk

### AI
- `Space aa` - AI actions menu
- `Space ac` - Toggle AI chat
- `Space ae` - Explain code
- `Space af` - Fix code
- `Space ad` - Add documentation

### LSP
- `K` - Show documentation
- `Space ca` - Code actions
- `Space rn` - Rename symbol
- `]d` / `[d` - Next/Previous diagnostic

### Terminal
- `Ctrl-\` - Toggle terminal

### Window Management
- `Space sv` - Split vertical
- `Space sh` - Split horizontal
- `Space sx` - Close split

## Quick Tips

### First Time Setup
1. Start nvim - plugins will auto-install
2. `:checkhealth` - verify everything works
3. `:Mason` - install language servers
4. Add API keys to `.env` file

### Switching AI Models
Edit `lua/plugins/ai.lua`:
- Change `adapter = "anthropic"` to `"openai"` or `"ollama"`
- Change model in schema.model.default

### Installing Language Servers
- `:Mason` - Opens package manager
- Search for your language
- Press `i` to install

### Updating Plugins
- `:Lazy` - Open plugin manager
- Press `U` to update all
- Press `S` to sync

## Tmux Quick Commands
- `tmux new -s myproject` - New session
- `Ctrl-b d` - Detach session
- `tmux ls` - List sessions
- `tmux attach -t myproject` - Attach to session
- `Ctrl-b c` - New window
- `Ctrl-b %` - Split vertical
- `Ctrl-b "` - Split horizontal
