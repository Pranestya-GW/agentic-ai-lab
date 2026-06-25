# pi.dev — Local AI Coding Agent

> Open-source terminal coding agent. Reads your codebase, answers questions, executes commands, and edits files.

## Quick Start

```bash
# Install
npm install -g @earendil-works/pi-coding-agent

# Run
cd ~/my-project
pi
```

## Key Features

- **Reads your entire codebase** — understands project context
- **Executes bash commands** — git, docker, npm, python
- **Edits files** — makes targeted code changes
- **File search** — grep, find, ls built-in
- **Multiple models** — Claude, GPT, Gemini via API keys

## Daily Workflow Examples

```bash
# Code review
pi "Review the latest commit and suggest improvements"

# Bug investigation
pi "Find why the login endpoint returns 500 errors"

# Documentation
pi "Write a README for this project"

# Refactoring
pi "Extract the database connection logic into a separate module"

# Database work
pi "Check all SQL files for missing foreign key constraints"
```

## Configuration

### API Key Setup

```bash
# Option A: Anthropic direct
export ANTHROPIC_API_KEY="sk-ant-..."

# Option B: OpenRouter (one key for all)
export OPENROUTER_API_KEY="sk-or-v1-..."
export OPENAI_API_KEY="$OPENROUTER_API_KEY"
export OPENAI_BASE_URL="https://openrouter.ai/api/v1"

# Option C: DeepSeek (cheapest — 500M tokens free)
export DEEPSEEK_API_KEY="sk-..."

# Permanent (add to ~/.bashrc)
echo 'export ANTHROPIC_API_KEY="sk-ant-..."' >> ~/.bashrc
# or
echo 'export OPENROUTER_API_KEY="sk-or-v1-..."' >> ~/.bashrc
# or
echo 'export DEEPSEEK_API_KEY="sk-..."' >> ~/.bashrc
source ~/.bashrc
```

pi stores config in `~/.config/pi/`. Set API keys:

```bash
export ANTHROPIC_API_KEY="sk-ant-..."
export OPENAI_API_KEY="sk-..."
export GEMINI_API_KEY="AIza..."
```

## Supercharge with pi-setup

Add custom extensions, themes (10+), skills, a safety guard, and sync tooling.

👉 **[Full pi-setup tutorial →](pi-setup.md)**

Quick install:

```bash
git clone https://github.com/abhinand5/pi-setup.git ~/pi-setup
cd ~/pi-setup
./install.sh --restore --copy-config
```

## Resources

- Docs: `pi --help`
- GitHub: https://github.com/earendil-works/pi
