# Language-Specific Setup Guide

## Python

### LSP Setup
```bash
pip install pyright ruff-lsp
```

### Formatters
```bash
pip install black isort ruff
```

### Virtual Environments
The LSP will automatically detect `.venv` or `venv` directories. To use a specific environment:
```bash
# In Neovim
:lua vim.lsp.buf.execute_command({command = '_pyright.selectPythonEnvironment'})
```

### Jupyter Integration (Optional)
```bash
pip install jupytext
# Convert notebooks: jupytext --to py notebook.ipynb
```

## Julia

### LSP Setup
In Julia REPL:
```julia
using Pkg
Pkg.add("LanguageServer")
Pkg.add("SymbolServer")
```

### Performance Tips
First startup may be slow. Julia LSP precompiles packages on first use.

### REPL Integration
Use `toggleterm` (Ctrl-\) and run:
```bash
julia
```

## Rust

### LSP Setup
```bash
rustup component add rust-analyzer
rustup component add rustfmt
rustup component add clippy
```

### Cargo Integration
Works automatically with Cargo projects. Run in terminal:
```bash
cargo build
cargo test
cargo run
```

### Debugging (Optional)
```bash
cargo install cargo-watch
# Auto-run tests: cargo watch -x test
```

## SQL / DuckDB

### LSP Setup
```bash
# Install sqls via Mason in Neovim
:Mason
# Search for sqls and press 'i' to install
```

### DuckDB Integration
```bash
# Install DuckDB CLI
wget https://github.com/duckdb/duckdb/releases/download/v0.9.0/duckdb_cli-linux-amd64.zip
unzip duckdb_cli-linux-amd64.zip
sudo mv duckdb /usr/local/bin/
```

### Configuration
Create `~/.config/sqls/config.yml`:
```yaml
connections:
  - alias: local
    driver: duckdb
    dataSourceName: /path/to/your/database.duckdb
```

### Usage
Open `.sql` file and use:
- `K` - Show table/column info
- `gd` - Go to table definition

## Stata

### Note
Stata doesn't have a widely-used LSP. Basic syntax highlighting works via Treesitter.

### Workflow Recommendation
1. Edit `.do` files in Neovim
2. Run in Stata terminal or batch mode:
```bash
stata -b do script.do
```

### Alternative: Stata Markdown
Use Markdown with code blocks for documentation:
````markdown
```stata
sysuse auto
summarize price mpg
```
````

## Bash/Shell

### LSP Setup
```bash
npm install -g bash-language-server
```

### ShellCheck Integration
```bash
# Ubuntu/Debian
sudo apt install shellcheck

# macOS
brew install shellcheck

# Other
wget https://github.com/koalaman/shellcheck/releases/latest/download/shellcheck-latest.linux.x86_64.tar.xz
tar -xvf shellcheck-latest.linux.x86_64.tar.xz
sudo mv shellcheck-latest/shellcheck /usr/local/bin/
```

## YAML

### LSP Setup
```bash
npm install -g yaml-language-server
```

### Schema Validation
For Kubernetes, GitHub Actions, etc., the LSP auto-detects schemas.

## JSON

### LSP Setup
Automatically installed via Mason (jsonls).

### Tips
- Use `Space cf` to format JSON
- LSP validates against JSON schemas

## Common Issues

### LSP Not Starting
1. Check installation: `:LspInfo`
2. Check logs: `:LspLog`
3. Reinstall: `:Mason` → find server → press `X` to uninstall, then `i` to install

### Formatter Not Found
```bash
# Check if installed
which black
which rustfmt
which stylua

# Install if missing
pip install black    # Python
cargo install stylua # Lua
```

### Slow Startup
1. Disable unused language parsers in `lua/plugins/treesitter.lua`
2. Use lazy loading (most plugins already lazy-loaded)
3. Profile startup: `nvim --startuptime startup.log`

### Python Virtual Environment Not Detected
Create a `.python-version` file in your project root:
```bash
echo "3.11" > .python-version
```

Or explicitly set in Neovim:
```vim
:lua vim.g.python3_host_prog = '/path/to/venv/bin/python'
```

## Testing Your Setup

### Python
```python
# test.py
def hello(name: str) -> str:
    """Say hello."""
    return f"Hello {name}"

print(hello("World"))
```
- Hover over function → Should show docs
- `gd` on function → Should jump to definition
- `Space cf` → Should format with black

### Julia
```julia
# test.jl
function fibonacci(n::Int)::Int
    n <= 1 ? n : fibonacci(n-1) + fibonacci(n-2)
end

println(fibonacci(10))
```

### Rust
```rust
// test.rs
fn main() {
    let numbers = vec![1, 2, 3, 4, 5];
    let sum: i32 = numbers.iter().sum();
    println!("Sum: {}", sum);
}
```

### SQL
```sql
-- test.sql
SELECT 
    customer_id,
    COUNT(*) as order_count,
    SUM(amount) as total_amount
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 5;
```

## Getting Help

- `:help lspconfig` - LSP configuration
- `:help treesitter` - Syntax highlighting
- `:checkhealth` - Verify setup
- `:Mason` - Manage language servers
