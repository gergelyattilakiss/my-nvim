#!/bin/bash

set -e

echo "Installing Neovim Configuration..."

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Backup existing config
if [ -d "$HOME/.config/nvim" ]; then
    echo -e "${YELLOW}Backing up existing Neovim config...${NC}"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Clone config
echo -e "${GREEN}Cloning Neovim config...${NC}"
git clone https://github.com/YOUR_USERNAME/my-nvim.git "$HOME/.config/nvim"

# Install Neovim if not present
if ! command -v nvim &> /dev/null; then
    echo -e "${YELLOW}Neovim not found. Installing...${NC}"

    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        brew install neovim
    elif [[ -f /etc/debian_version ]]; then
        # Debian/Ubuntu
        sudo apt-get update
        sudo apt-get install -y neovim
    elif [[ -f /etc/redhat-release ]]; then
        # RHEL/CentOS/Fedora
        sudo yum install -y neovim
    else
        echo -e "${RED}Please install Neovim manually${NC}"
        exit 1
    fi
fi

# Check Neovim version
echo -e "${GREEN}Checking Neovim version...${NC}"
nvim_version=$(nvim --version | head -n1 | grep -oP '\d+\.\d+')
required_version="0.9"

if (( $(echo "$nvim_version < $required_version" | bc -l) )); then
    echo -e "${RED}Neovim version $nvim_version is too old. Please upgrade to 0.9+${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Neovim version $nvim_version${NC}"

# Install dependencies
echo -e "${GREEN}Installing language servers and tools...${NC}"

# Python tools
if command -v pip3 &> /dev/null; then
    echo "Installing Python tools..."
    pip3 install --user pynvim pyright black isort ruff
fi

# Node.js tools (if available)
if command -v npm &> /dev/null; then
    echo "Installing Node.js language servers..."
    npm install -g bash-language-server yaml-language-server
fi

# Rust tools (if cargo available)
if command -v cargo &> /dev/null; then
    echo "Installing Rust tools..."
    rustup component add rust-analyzer rustfmt clippy
fi

# Other tools
if command -v apt-get &> /dev/null; then
    sudo apt-get install -y ripgrep fd-find
elif command -v yum &> /dev/null; then
    sudo yum install -y ripgrep fd-find
elif command -v brew &> /dev/null; then
    brew install ripgrep fd
fi

echo -e "${GREEN}✓ Dependencies installed${NC}"

# Create API key placeholder file
cat > "$HOME/.config/nvim/.env.example" << 'EOF'
# AI API Keys (copy this to .env and add your keys)
export ANTHROPIC_API_KEY="your-key-here"
export OPENAI_API_KEY="your-key-here"

# Source this file: source ~/.config/nvim/.env
EOF

echo -e "${YELLOW} Don't forget to:${NC}"
echo "1. Copy .env.example to .env and add your API keys"
echo "2. Run: source ~/.config/nvim/.env"
echo "3. Start Neovim and wait for plugins to install"
echo ""
echo -e "${GREEN} Installation complete! Run 'nvim' to start${NC}"
