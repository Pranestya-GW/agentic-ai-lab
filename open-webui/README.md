# Open WebUI — ChatGPT-like Interface for Local Models

> Self-hosted web chat interface for Ollama and OpenAI-compatible APIs. Like ChatGPT but for your local models.

## Quick Start

```bash
./install-open-webui.sh
# → http://localhost:3000
```

## First-Time Setup

1. Open **http://localhost:3000**
2. Create an admin account (first user is admin)
3. Go to **Settings** (gear icon) → **Connections**
4. Set Ollama API: `http://host.docker.internal:11434`
5. (Optional) Add cloud APIs:
   - **OpenAI:** Enter your `OPENAI_API_KEY`
   - **OpenRouter:** Base URL `https://openrouter.ai/api/v1` + your key
   - **DeepSeek:** Base URL `https://api.deepseek.com/v1` + your key (500M tokens free!)
6. Click **Refresh** — your models appear
7. Start chatting!

## Features

- **ChatGPT-like UI** — familiar interface
- **Multiple models** — switch between Qwen 7B, 14B, 32B
- **Chat history** — saved in Docker volume
- **Code syntax highlighting** — Markdown + code blocks
- **Model management** — pull/delete models from UI
- **RAG support** — upload documents for context
- **Web search** — pluggable search integration

## Managing Models in Open WebUI

- **Pull new model:** Settings → Models → enter name (e.g., `llama3.2:3b`)
- **Delete model:** Click ⋮ on model card → Delete
- **Switch model:** Select from dropdown in chat view

## Docker Management

```bash
# Stop
docker stop open-webui

# Start
docker start open-webui

# Update
docker pull ghcr.io/open-webui/open-webui:main
docker rm -f open-webui
./install-open-webui.sh
```

## Resources

- GitHub: https://github.com/open-webui/open-webui
- Docs: https://docs.openwebui.com
