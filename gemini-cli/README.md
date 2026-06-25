# Gemini CLI — Google AI in Terminal

> Google's official CLI for Gemini models. Access 1M token context window directly from your terminal.

## Quick Start

### API Key Setup

```bash
# Get key: https://aistudio.google.com/apikey
# Or use OpenRouter: https://openrouter.ai/keys
# Or use DeepSeek: https://platform.deepseek.com/api_keys  (500M tokens free)

# Temporary (this session only)
export GEMINI_API_KEY="AIza..."

# Permanent (add to ~/.bashrc)
echo 'export GEMINI_API_KEY="AIza..."' >> ~/.bashrc
source ~/.bashrc
```

### Install

```bash
npm install -g @google/gemini-cli

# Run
gemini
```

## Key Features

- **1M token context** — largest available, fits entire codebases
- **Multimodal** — process text, images, audio
- **Free tier** — 15 requests/minute on AI Studio
- **Google Search grounding** — fact-check against web

## Daily Workflow Examples

```bash
# Interactive mode
gemini

# Database query help
gemini "Write a PostgreSQL query to find overlapping date ranges"

# Code explanation
cat server.js | gemini "Explain what this Express server does"

# Architecture review
gemini "Review this docker-compose.yml for security issues" < docker-compose.yml

# One-shot with system prompt
gemini --prompt "You are a PostgreSQL DBA expert" "Check this schema"
```

## Models Available

| Model | Context | Best For |
|-------|---------|----------|
| `gemini-2.5-flash` | 1M | Fast, lightweight |
| `gemini-2.5-pro` | 1M | Complex reasoning |
| `gemini-2.5-flash-lite` | 1M | Cheapest, fastest |

## Resources

- API keys: https://aistudio.google.com/apikey
- Docs: https://ai.google.dev/gemini-api/docs
- 🔒 **[Safety setup →](safety-setup.md)** — make Gemini ask permission first
