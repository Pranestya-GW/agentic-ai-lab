# pi.dev — Local AI Coding Agent Tutorial

> Step-by-step guide to install and use pi.dev, an open-source terminal coding agent.

---

### 1. Install Node.js (if not already installed)

```bash
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
node --version  # confirm it's installed (should be 20+)
```

### 2. Install pi.dev globally

```bash
npm install -g --ignore-scripts @earendil-works/pi-coding-agent
```

> The `--ignore-scripts` flag is recommended by the official docs to avoid unnecessary build steps.

### 3. Verify the installation

```bash
pi --version  # should print the installed version
```

### 4. Set a permanent API key (pick one option)

```bash
# Option A: DeepSeek (cheapest — 500M tokens free on signup)
# Get key: https://platform.deepseek.com/api_keys
echo 'export DEEPSEEK_API_KEY="sk-your-deepseek-key-here"' >> ~/.bashrc
source ~/.bashrc

# Option B: Anthropic (best quality for code)
# Get key: https://console.anthropic.com/
echo 'export ANTHROPIC_API_KEY="sk-ant-your-key-here"' >> ~/.bashrc
source ~/.bashrc

# Option C: OpenRouter (one key for 200+ models)
# Get key: https://openrouter.ai/keys
echo 'export OPENROUTER_API_KEY="sk-or-v1-your-key-here"' >> ~/.bashrc
echo 'export OPENAI_API_KEY="$OPENROUTER_API_KEY"' >> ~/.bashrc
echo 'export OPENAI_BASE_URL="https://openrouter.ai/api/v1"' >> ~/.bashrc
source ~/.bashrc
```

### 5. Ready to use — start pi in your project

```bash
cd /path/to/your/project
pi
```

### 6. Try some queries inside pi

```text
# Inside the interactive session:
"Explain the structure of this project"
"Find all SQL files and check for missing indexes"
"Write a Python function to parse JSON logs"
```

### 7. One-shot mode (non-interactive)

```bash
pi "Count the number of Python files in this project"
```

### 8. Use a specific model

```bash
pi --model claude-sonnet-4-20250514 "Review this codebase for security issues"
```

---

## 9. Recommended Stack

Set up the recommended provider, plugins, and skills for the best pi.dev experience:

### Set DeepSeek as default provider

```bash
# DeepSeek API — cheapest, 500M tokens free on signup
# Get key: https://platform.deepseek.com/api_keys
export DEEPSEEK_API_KEY="sk-your-key-here"

# pi.dev config
echo 'export DEEPSEEK_API_KEY="sk-your-key-here"' >> ~/.bashrc
source ~/.bashrc
```

- **Docs:** https://api-docs.deepseek.com/
- **API Base:** https://api.deepseek.com/v1
- **Default model:** `deepseek-v4-flash`

### Install recommended plugins

```bash
pi plugins install context-mode          # hemat context window
pi plugins install pi-deepseek-search    # biar DeepSeek bisa web search
pi plugins install pi-codex-goal         # goal mode
pi plugins install @juicesharp/rpiv-ask-user-question  # interactive ask
```

### Install the grilling skill

```bash
pi skills install mattpocock/skills/grilling
```

---

## Resources

- Docs: `pi --help`
- Website: https://pi.dev
- GitHub: https://github.com/earendil-works/pi
