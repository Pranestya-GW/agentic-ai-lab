# Qwen Coder — Local AI via Ollama

> Alibaba's Qwen 2.5 Coder running entirely on your machine via Ollama. No internet, no API keys, no limits.

## Quick Start

```bash
# Install (no API key needed — runs fully offline)
./install-qwen-coder.sh

# Chat
ollama run qwen2.5-coder:7b
```

## Model Sizes

| Model | RAM | Disk | Quality |
|-------|-----|------|---------|
| `qwen2.5-coder:7b` | 8 GB | ~4 GB | Good for daily tasks |
| `qwen2.5-coder:14b` | 16 GB | ~9 GB | Better reasoning |
| `qwen2.5-coder:32b` | 32 GB | ~20 GB | Production quality |

## Usage Examples

```bash
# Interactive chat
ollama run qwen2.5-coder:7b

# One-shot queries
ollama run qwen2.5-coder:7b "Write a Python script to parse PostgreSQL CSV logs"

# Pipe code for analysis
cat app.py | ollama run qwen2.5-coder:7b "Find security vulnerabilities"

# SQL generation
ollama run qwen2.5-coder:7b "Write a query to find duplicate records grouped by email"
```

## API Access

Ollama exposes a REST API at `http://localhost:11434`:

```bash
# Generate
curl http://localhost:11434/api/generate -d '{
  "model": "qwen2.5-coder:7b",
  "prompt": "Write a PostgreSQL function to calculate age from birth_date",
  "stream": false
}'

# Chat
curl http://localhost:11434/api/chat -d '{
  "model": "qwen2.5-coder:7b",
  "messages": [{"role": "user", "content": "Explain EXPLAIN ANALYZE output"}]
}'
```

## Use Cases

| When to use Qwen (local) | When to use Cloud APIs |
|---------------------------|------------------------|
| Offline/air-gapped work | Fast iteration |
| Sensitive/private code | Large context needed |
| No budget for API | Best quality output |
| Learning/experimenting | 1M token analysis |
| Repetitive tasks | Multimodal (images) |

> 💡 **Need cloud but low budget?** Try DeepSeek direct API at **$0.27/1M tokens** with **500M free** on signup — [platform.deepseek.com](https://platform.deepseek.com/api_keys)

## Resources

- Ollama: https://ollama.com
- Qwen 2.5: https://github.com/QwenLM/Qwen2.5-Coder
- 🔒 **[Safety setup →](safety-setup.md)** — system prompt and Modelfile safety
