# 🧠 Agentic AI Lab — WSL Development Environment

> One-folder setup for experimenting with AI coding agents on WSL/Linux: **pi.dev**, **Gemini CLI**, **Claude Code**, and **Qwen Coder** (local via Ollama). Includes setup scripts, API key configuration, and usage tutorials.

---

## Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [Tool Comparison](#tool-comparison)
- [1. pi.dev — Local Coding Agent](#1-pidev--local-coding-agent)
- [2. Gemini CLI — Google AI in Terminal](#2-gemini-cli--google-ai-in-terminal)
- [3. Claude Code — Anthropic in Terminal](#3-claude-code--anthropic-in-terminal)
- [4. Qwen Coder — Local AI via Ollama](#4-qwen-coder--local-ai-via-ollama)
- [Bonus: Open WebUI — Chat Interface](#bonus-open-webui--chat-interface)
- [Safety Guides](#safety-guides)
- [API Key Management](#api-key-management)
- [Troubleshooting](#troubleshooting)

---

## Overview

This lab provides everything you need to experiment with 4 AI coding agents side-by-side:

```
┌─────────────────────────────────────────────────────────────┐
│  WSL / Linux Environment                                     │
│                                                              │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │ pi.dev   │  │ Gemini   │  │ Claude   │  │ Qwen     │   │
│  │ (local)  │  │ CLI      │  │ Code     │  │ Coder    │   │
│  │          │  │ (cloud)  │  │ (cloud)  │  │ (local)  │   │
│  │ npm pkg  │  │ npm pkg  │  │ npm pkg  │  │ Ollama   │   │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬─────┘   │
│       └─────────────┴─────────────┴─────────────┘          │
│                         │                                     │
│                  ┌──────┴──────┐                             │
│                  │  OpenRouter  │  ← One API key for all     │
│                  │  (unified)   │    200+ models             │
│                  └─────────────┘                              │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Open WebUI  (chat interface for local models)        │   │
│  │  http://localhost:3000                                │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

---

## Quick Start

### Prerequisites

- WSL2 with Ubuntu 22.04+
- Node.js 20+ (for npm packages)
- Python 3.10+ (for pi.dev)
- Docker (for Open WebUI)
- 8 GB+ RAM (for local models)

### Install Everything

```bash
cd ~/Desktop/agentic-ai-lab

# Make scripts executable
chmod +x install-*.sh

# Install all tools
./install-all.sh

# Or install individually:
./install-openrouter.sh     # One API key for all cloud models
./install-pi-dev.sh         # Local coding agent
./install-gemini-cli.sh     # Needs GEMINI_API_KEY or OpenRouter
./install-claude-code.sh    # Needs ANTHROPIC_API_KEY or OpenRouter
./install-qwen-coder.sh     # Needs Ollama + 8GB RAM
./install-open-webui.sh     # Needs Docker
```

---

## Tool Comparison

| Feature | pi.dev | Gemini CLI | Claude Code | Qwen Coder |
|---------|--------|------------|-------------|------------|
| **Runtime** | Local | Cloud (Google) | Cloud (Anthropic) | Local (Ollama) |
| **Cost** | Free OSS | Pay-per-token | Pay-per-token | Free |
| **Internet** | Not required | Required | Required | Not required |
| **Code quality** | Good (Anthropic) | Very good | Excellent | Good |
| **Speed** | Fast | Fast | Fast | Depends on GPU |
| **Context window** | 200K | 1M | 200K | 128K (Qwen 2.5) |
| **Privacy** | Full (local) | Cloud | Cloud | Full (local) |
| **Best for** | Daily coding | Google integration | Complex refactors | Offline/private work |
| **Install** | `npm install -g` | `npm install -g` | `npm install -g` | Ollama pull |
| **API Key** | Free signup | Google AI Studio | Anthropic Console | None |

---

## 0. OpenRouter — One API Key for All Cloud Models

**Website:** https://openrouter.ai

Instead of managing 5 separate API keys, use OpenRouter as a unified gateway to 200+ models (Claude, GPT, Gemini, Qwen, Llama, Mistral, DeepSeek). Same models, same prices, zero-log by default.

### Setup

```bash
# Get key: https://openrouter.ai/keys
export OPENROUTER_API_KEY="sk-or-v1-..."
./install-openrouter.sh
```

### Usage

```bash
# Direct curl to any model
curl https://openrouter.ai/api/v1/chat/completions \
  -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model":"google/gemini-2.5-flash","messages":[{"role":"user","content":"Hello"}]}'
```

```python
from openai import OpenAI
client = OpenAI(
    base_url="https://openrouter.ai/api/v1",
    api_key="sk-or-v1-...",
)
response = client.chat.completions.create(
    model="anthropic/claude-sonnet-4-20250514",
    messages=[{"role": "user", "content": "Write a SQL query"}],
)
```

### Best Models via OpenRouter

| Task | Model | Cost/1M tokens |
|------|-------|----------------|
| Best code | `anthropic/claude-sonnet-4-20250514` | $3/$15 |
| Cheapest good | `google/gemini-2.5-flash` | $0.15/$0.60 |
| Budget coding | `deepseek/deepseek-chat-v3` | $0.89/$1.79 |
| Open-source | `meta-llama/llama-4-maverick` | $0.20/$0.90 |
| Local alt | `qwen/qwen-2.5-coder-32b` | $0.18/$0.72 |

> 💡 **DeepSeek has its own API** — cheaper direct: `deepseek-chat` at **$0.27/$1.10** + 500M free tokens on signup. Get key at [platform.deepseek.com](https://platform.deepseek.com/api_keys).

---

## 1. pi.dev — Local Coding Agent

**Website:** https://pi.dev  
**Repo:** `@earendil-works/pi-coding-agent`

### Installation

```bash
./install-pi-dev.sh
```

Or manually:

```bash
# Install Node.js (if not already)
curl -fsSL https://fnm.vercel.app/install | bash
fnm install 22

# Install pi
npm install -g @earendil-works/pi-coding-agent

# Run
pi
```

### Basic Usage

```bash
# Start pi in current directory
cd ~/my-project
pi

# Inside pi, you can:
#   "Read the README and explain the project"
#   "Find all SQL files and check for missing indexes"
#   "Write a function to parse JSON logs"
```

### Key Commands

| Command | Description |
|---------|-------------|
| `pi` | Start interactive session |
| `pi "query"` | One-shot query |
| `pi --model claude-sonnet-4-20250514` | Use specific model |

### Supercharge Pi with pi-setup

Add extensions, themes, skills, a safety guard, and sync tooling. See the full guide:

👉 **[`pi-dev/pi-setup.md`](pi-dev/pi-setup.md)**

Quick install:

```bash
git clone https://github.com/abhinand5/pi-setup.git ~/pi-setup
cd ~/pi-setup
./install.sh --restore --copy-config
```

---

## 2. Gemini CLI — Google AI in Terminal

**Website:** https://ai.google.dev  
**Package:** `@google/gemini-cli`

### Prerequisites

Get a free API key from [Google AI Studio](https://aistudio.google.com/apikey).

### Installation

```bash
GEMINI_API_KEY="your-key-here" ./install-gemini-cli.sh
```

Or manually:

```bash
# Install
npm install -g @google/gemini-cli

# Set API key (add to ~/.bashrc for persistence)
export GEMINI_API_KEY="your-key-here"

# Run
gemini
```

### Basic Usage

```bash
# Interactive mode
gemini

# One-shot query
gemini "Explain this SQL query: SELECT ..."

# Chat mode with system prompt
gemini --prompt "You are a PostgreSQL expert"

# Pipe files
cat query.sql | gemini "Optimize this query"
```

---

## 3. Claude Code — Anthropic in Terminal

**Website:** https://claude.ai  
**Package:** `@anthropic-ai/claude-code`

### Prerequisites

Get an API key from [Anthropic Console](https://console.anthropic.com/).

### Installation

```bash
ANTHROPIC_API_KEY="your-key-here" ./install-claude-code.sh
```

Or manually:

```bash
# Install
npm install -g @anthropic-ai/claude-code

# Set API key
export ANTHROPIC_API_KEY="your-key-here"

# Run
claude
```

### Basic Usage

```bash
# Interactive mode
claude

# One-shot
claude "Write a Python script to parse PostgreSQL logs"

# With file context
claude --file schema.sql "Add indexes to this schema"

# Use specific model
claude --model claude-sonnet-4-20250514
```

---

## 4. Qwen Coder — Local AI via Ollama

**Qwen 2.5 Coder:** Alibaba's code-specialized model, runs entirely locally.

### Installation

```bash
./install-qwen-coder.sh
```

Or manually:

```bash
# Install Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Pull Qwen Coder models
ollama pull qwen2.5-coder:7b      # ~4 GB, fast on CPU
ollama pull qwen2.5-coder:14b     # ~9 GB, needs 16GB RAM
ollama pull qwen2.5-coder:32b     # ~20 GB, needs 32GB RAM

# Test
ollama run qwen2.5-coder:7b "Write a Python function to connect to PostgreSQL"
```

### Choosing the Right Model Size

| Model | RAM Needed | Speed | Quality |
|-------|-----------|-------|---------|
| `qwen2.5-coder:7b` | 8 GB | Fast (CPU) | Good for simple tasks |
| `qwen2.5-coder:14b` | 16 GB | Medium | Better reasoning |
| `qwen2.5-coder:32b` | 32 GB | Slow (without GPU) | Best quality |

### Using via API

Ollama exposes a REST API at `http://localhost:11434`:

```bash
# List models
curl http://localhost:11434/api/tags

# Generate code
curl http://localhost:11434/api/generate -d '{
  "model": "qwen2.5-coder:7b",
  "prompt": "Write a PostgreSQL query to find duplicate records",
  "stream": false
}'
```

---

## Bonus: Open WebUI — Chat Interface

A ChatGPT-like web interface for your local Ollama models.

### Installation

```bash
./install-open-webui.sh
```

Or manually:

```bash
docker run -d \
  -p 3000:8080 \
  --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  --name open-webui \
  --restart always \
  ghcr.io/open-webui/open-webui:main
```

**Access:** http://localhost:3000

---

## Safety Guides

Every AI agent can edit files and run commands. Here's how to make each one ask permission first:

| Tool | Safety Guide | Best safety feature |
|---|---|---|
| **pi.dev** | [`pi-dev/pi-setup.md`](pi-dev/pi-setup.md) | `/safety` guard + `/filechanges` review |
| **Gemini CLI** | [`gemini-cli/safety-setup.md`](gemini-cli/safety-setup.md) | `--approval-mode default` + `--sandbox` |
| **Claude Code** | [`claude-code/safety-setup.md`](claude-code/safety-setup.md) | `--permission-mode default` + `.claude/settings.json` |
| **Qwen Coder** | [`qwen-coder/safety-setup.md`](qwen-coder/safety-setup.md) | Custom Modelfile with safety rules |

Quick summary:

```bash
# pi.dev  — install safety extension
cd ~/pi-setup && ./install.sh --restore --copy-config

# Gemini CLI  — always ask
Gemini --approval-mode default

# Claude Code  — always ask
claude --permission-mode default

# Qwen Coder  — permanent safety rules
ollama create safety-qwen -f Modelfile.safety-qwen
```

---

## API Key Management

Each tool needs its API key available as an environment variable. You have 3 options:

### Option 1: Per-session (temporary)

```bash
export GEMINI_API_KEY="AIza..."
export ANTHROPIC_API_KEY="sk-ant-..."
export OPENROUTER_API_KEY="sk-or-v1-..."
export DEEPSEEK_API_KEY="sk-..."
```

### Option 2: Permanent via `~/.bashrc` (recommended)

```bash
# Add each key permanently — survives reboots and new terminal sessions
echo 'export GEMINI_API_KEY="AIza..."' >> ~/.bashrc
echo 'export ANTHROPIC_API_KEY="sk-ant-..."' >> ~/.bashrc
echo 'export OPENROUTER_API_KEY="sk-or-v1-..."' >> ~/.bashrc
echo 'export DEEPSEEK_API_KEY="sk-..."' >> ~/.bashrc

# Apply immediately
source ~/.bashrc
```

### Option 3: `.env` file in your project

```bash
# .env
GEMINI_API_KEY=AIza...
ANTHROPIC_API_KEY=sk-ant-...
OPENROUTER_API_KEY=sk-or-v1-...
```

Load with: `source .env` or use `python-dotenv`.

### Getting Free API Keys

| Service | URL | Free Tier |
|---------|-----|-----------|
| **Google AI Studio** | https://aistudio.google.com/apikey | 15 RPM free |
| **Anthropic Console** | https://console.anthropic.com/ | $5 credit |
| **OpenRouter** | https://openrouter.ai/keys | $1 credit (200+ models) |
| **DeepSeek** | https://platform.deepseek.com/api_keys | 500M tokens free |
| **pi.dev** | https://pi.dev | Free signup |

---

## Troubleshooting

### Node.js not found

```bash
curl -fsSL https://fnm.vercel.app/install | bash
fnm install 22
fnm use 22
```

### npm permission errors

```bash
# Configure npm to use user directory
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

### Ollama slow on WSL

- Ensure WSL2 is being used: `wsl --set-version Ubuntu 2`
- Increase WSL memory in `%USERPROFILE%\.wslconfig`:

```ini
[wsl2]
memory=16GB
processors=8
```

- Use the 7B model if RAM is limited

### Open WebUI can't connect to Ollama

By default Ollama only listens on `127.0.0.1`. To allow Docker access:

```bash
# Edit Ollama service
sudo systemctl edit ollama

# Add:
[Service]
Environment="OLLAMA_HOST=0.0.0.0"

# Restart
sudo systemctl restart ollama
```

### Gemini CLI auth error

```bash
# Verify your key works
curl "https://generativelanguage.googleapis.com/v1/models?key=$GEMINI_API_KEY"
```
