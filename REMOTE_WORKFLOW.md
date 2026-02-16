# Remote Development Workflow Guide

## Initial Setup on Remote Server

### 1. Install Config
```bash
# SSH into your server
ssh user@remote-server

# Quick install
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/my-nvim/main/install.sh | bash

# Or manual
git clone https://github.com/YOUR_USERNAME/my-nvim.git ~/.config/nvim
```

### 2. Setup API Keys
```bash
# Copy example file
cp ~/.config/nvim/.env.example ~/.config/nvim/.env

# Edit with your keys
nano ~/.config/nvim/.env

# Add to your shell rc
echo 'source ~/.config/nvim/.env' >> ~/.bashrc
source ~/.bashrc
```

### 3. First Run
```bash
nvim
# Wait for plugins to install (takes 1-2 minutes)
# Then quit and restart
```

## Typical Workflow

### Project 1: Python Data Analysis

```bash
# Create/attach to tmux session
tmux new -s data-analysis

# Navigate to project
cd ~/projects/data-analysis

# Open Neovim
nvim main.py

# Inside Neovim:
# - Space ee    → File explorer
# - Space ff    → Find files
# - Space fg    → Search in project
# - Space ac    → AI chat for help
```

### Project 2: Julia Simulation

```bash
# New tmux window or pane
# Ctrl-b c (new window) OR Ctrl-b % (split pane)

# Navigate to different project
cd ~/projects/simulation

# Open Neovim
nvim simulation.jl

# Use Ctrl-h/j/k/l to move between tmux panes and nvim splits
```

### Project 3: Rust Development

```bash
# Another tmux window
# Ctrl-b c

cd ~/projects/rust-project

# Open Neovim
nvim src/main.rs

# Cargo commands in terminal (Ctrl-\)
cargo build
cargo test
cargo run
```

## Multi-Project Management with Tmux

### Session Layout Example

```
Session: work
├── Window 0: data-analysis (Python)
│   ├── Pane 0: nvim (main editor)
│   ├── Pane 1: python REPL
│   └── Pane 2: htop (monitoring)
│
├── Window 1: simulation (Julia)
│   ├── Pane 0: nvim
│   └── Pane 1: julia REPL
│
└── Window 2: backend (Rust)
    ├── Pane 0: nvim
    └── Pane 1: cargo watch
```

### Creating This Layout

```bash
# Create session
tmux new -s work

# Window 0 - Python project
cd ~/projects/data-analysis
nvim main.py
# Ctrl-b % (split vertical)
# Type: python
# Ctrl-b " (split horizontal in right pane)
# Type: htop

# Window 1 - Julia project
# Ctrl-b c (new window)
cd ~/projects/simulation
nvim simulation.jl
# Ctrl-b % (split)
# Type: julia

# Window 2 - Rust project  
# Ctrl-b c (new window)
cd ~/projects/rust-project
nvim src/main.rs
# Ctrl-b % (split)
# Type: cargo watch -x test

# Navigate between windows
# Ctrl-b 0/1/2 (jump to window)
# Ctrl-b n/p (next/previous window)
```

## Daily Workflow

### Morning Routine
```bash
# SSH into server
ssh user@remote-server

# Attach to existing session
tmux attach -t work

# Or list all sessions
tmux ls

# Or create new if none exists
tmux new -s work
```

### During Work
```bash
# Inside tmux + nvim:
# - Use Ctrl-h/j/k/l to navigate between panes
# - Use Space ff/fg to find files/text
# - Use Space ac to ask AI for help
# - Use Space gg for git operations
# - Use Ctrl-\ to toggle terminal

# Switching projects:
# - Ctrl-b 0/1/2 to switch windows
# - OR Ctrl-b w to see window list
```

### End of Day
```bash
# Detach from session (keeps it running)
# Ctrl-b d

# Everything stays running!
# Reconnect tomorrow with: tmux attach -t work
```

## Advanced Patterns

### Database Work with DuckDB
```bash
# Window 4: database
cd ~/data
nvim queries.sql
# Ctrl-b %
duckdb mydata.db

# Run queries from nvim, see results in duckdb pane
```

### Monitoring Long-Running Jobs
```bash
# Start job in background
python long_script.py > output.log 2>&1 &

# Watch logs in a pane
tail -f output.log

# Work on other things in other panes
# Check progress with Ctrl-h/j/k/l navigation
```

### Multiple Server Setup
```bash
# In your LOCAL machine ~/.ssh/config:
Host server1
    HostName 192.168.1.10
    User myuser
    
Host server2
    HostName 192.168.1.11
    User myuser

# Connect to each:
ssh server1
tmux attach -t work1

# New terminal tab/window
ssh server2  
tmux attach -t work2
```

## Tmux Cheatsheet for This Setup

### Sessions
- `tmux new -s name` - Create session
- `tmux attach -t name` - Attach to session
- `tmux ls` - List sessions
- `Ctrl-b d` - Detach from session
- `Ctrl-b $` - Rename session

### Windows (Tabs)
- `Ctrl-b c` - Create window
- `Ctrl-b ,` - Rename window
- `Ctrl-b n/p` - Next/Previous window
- `Ctrl-b 0-9` - Jump to window
- `Ctrl-b w` - List windows

### Panes (Splits)
- `Ctrl-b %` - Split vertical
- `Ctrl-b "` - Split horizontal
- `Ctrl-b x` - Close pane
- `Ctrl-h/j/k/l` - Navigate panes (works with nvim!)
- `Ctrl-b z` - Zoom pane (full screen toggle)

### Copy Mode
- `Ctrl-b [` - Enter copy mode
- `Space` - Start selection
- `Enter` - Copy selection
- `Ctrl-b ]` - Paste

## Tips & Tricks

### Keep Processes Running
```bash
# Use tmux instead of nohup
# Benefits:
# - Can reattach and see output
# - Can interact with process
# - Multiple processes visible at once
```

### Persistent Sessions
```bash
# Install tmux-resurrect plugin (optional)
# Add to ~/.tmux.conf:
set -g @plugin 'tmux-plugins/tmux-resurrect'

# Save: Ctrl-b Ctrl-s
# Restore: Ctrl-b Ctrl-r
```

### Custom Tmux Config
Create `~/.tmux.conf`:
```bash
# Better colors
set -g default-terminal "screen-256color"

# Mouse support
set -g mouse on

# Start windows at 1
set -g base-index 1

# Faster command sequences
set -s escape-time 0

# Status bar
set -g status-style 'bg=#333333 fg=#5eacd3'

# Vim navigation (already configured by install script)
# ... vim-tmux-navigator config ...
```

### Git Integration
```bash
# In any nvim window:
# Space gg → Opens LazyGit
# Make commits, push/pull, view history
# All within tmux session
```

## Troubleshooting

### SSH Connection Drops
- Use `mosh` instead of `ssh` for unstable connections
- Or use tmux with `tmux attach || tmux new`

### Tmux Not Found
```bash
# Ubuntu/Debian
sudo apt install tmux

# CentOS/RHEL
sudo yum install tmux

# macOS
brew install tmux
```

### Nvim Not Syncing Between Sessions
```bash
# Each session has its own nvim instance
# Use Git for syncing:
# - Space gg (LazyGit)
# - Commit and push regularly
```

### Colors Look Wrong
```bash
# Add to ~/.bashrc:
export TERM=xterm-256color

# In tmux.conf:
set -g default-terminal "screen-256color"
```
