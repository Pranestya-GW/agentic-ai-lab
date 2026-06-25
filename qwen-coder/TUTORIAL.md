# Qwen Coder — Local AI via Ollama Tutorial

> Step-by-step guide to run Qwen 2.5 Coder entirely on your machine — no internet, no API keys, no limits.

---

### 1. Check system requirements

```bash
# Minimum: 8 GB RAM for the 7B model
# Recommended: 16 GB RAM for the 14B model
free -h  # check available RAM
```

### 2. Install Ollama

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

### 3. Verify Ollama is installed

```bash
ollama --version  # should print the installed version
```

### 4. Pull the Qwen 2.5 Coder model (choose your size)

```bash
# 7B model (~4 GB) — works on 8 GB RAM, fast on CPU
ollama pull qwen2.5-coder:7b

# 14B model (~9 GB) — needs 16 GB RAM, better reasoning
# ollama pull qwen2.5-coder:14b

# 32B model (~20 GB) — needs 32 GB RAM, best quality
# ollama pull qwen2.5-coder:32b
```

### 5. Verify the model was downloaded

```bash
ollama list  # should show qwen2.5-coder:7b and its size
```

### 6. Start an interactive chat

```bash
ollama run qwen2.5-coder:7b
```

### 7. Try some coding prompts

```text
# Inside the interactive session:
"Write a Python function to connect to PostgreSQL using psycopg2"
"Create a bash script to backup all PostgreSQL databases"
"Explain how window functions work in SQL with examples"
```

### 8. One-shot queries (non-interactive)

```bash
ollama run qwen2.5-coder:7b "Write a Python script to parse nginx access logs and find top 10 IPs"
```

### 9. Pipe code for analysis

```bash
cat app.py | ollama run qwen2.5-coder:7b "Find security vulnerabilities in this code"
```

### 10. Use the REST API (for programmatic access)

```bash
# The Ollama API runs at http://localhost:11434

# Generate completion
curl http://localhost:11434/api/generate -d '{
  "model": "qwen2.5-coder:7b",
  "prompt": "Write a PostgreSQL function to calculate age from birth_date",
  "stream": false
}'

# Chat completion
curl http://localhost:11434/api/chat -d '{
  "model": "qwen2.5-coder:7b",
  "messages": [{"role": "user", "content": "Explain EXPLAIN ANALYZE output in PostgreSQL"}]
}'
```

### 11. List all available models in Ollama

```bash
ollama list
```

### 12. Remove a model (if you need to free up space)

```bash
ollama rm qwen2.5-coder:7b  # removes the model to free ~4 GB
```

---

## Resources

- Ollama: https://ollama.com
- Qwen 2.5 Coder: https://github.com/QwenLM/Qwen2.5-Coder
- Ollama API Docs: https://github.com/ollama/ollama/blob/main/docs/api.md
