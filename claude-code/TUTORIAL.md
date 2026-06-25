# Claude Code — Anthropic in Terminal Tutorial

> Step-by-step guide to install and use Anthropic's Claude Code for complex coding tasks.

---

### 1. Install Node.js (if not already installed)

```bash
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
node --version  # confirm it's installed (should be 20+)
```

### 2. Get an Anthropic API key

```bash
# Open https://console.anthropic.com/ in your browser
# Sign up / Log in
# Go to API Keys → Create Key
# Copy the key: sk-ant-...
# New accounts get $5 free credit
```

### 3. Set the API key permanently

```bash
echo 'export ANTHROPIC_API_KEY="sk-ant-your-key-here"' >> ~/.bashrc
source ~/.bashrc
```

### 4. Verify the key is set

```bash
echo $ANTHROPIC_API_KEY  # should show your key
```

### 5. Install Claude Code globally

```bash
npm install -g @anthropic-ai/claude-code
```

### 6. Verify the installation

```bash
claude --version  # should print the installed version
claude --help     # show available commands
```

### 7. Start interactive mode in your project

```bash
cd /path/to/your/project
claude
```

### 8. Try some coding tasks inside claude

```text
# Inside the interactive session:
"Review the latest commit and suggest improvements"
"Find why the login endpoint returns 500 errors"
"Write unit tests for the database module"
```

### 9. One-shot queries

```bash
claude "Write a Python ETL script that reads CSV files and inserts into PostgreSQL"
```

### 10. Analyze files with context

```bash
claude --file schema.sql "Add proper indexes to this database schema"
```

### 11. Debug with git context

```bash
claude "The tests broke after the last commit. Find and fix the issue."
```

### 12. Use a specific Claude model

```bash
# Best for daily coding:
claude --model claude-sonnet-4-20250514 "Refactor this code"

# Best for complex reasoning:
claude --model claude-opus-4-20250514 "Design a microservices architecture for this monolith"
```

---

## Resources

- API Keys: https://console.anthropic.com/
- Docs: https://docs.anthropic.com/en/docs/claude-code
