# Qwen Coder — Safety Setup

> Qwen runs locally via Ollama. Safety comes from how you configure the system prompt and Modelfile.

---

## How safety works locally

Unlike cloud tools, Qwen runs **entirely on your machine**. It has no built-in permission system — but you control what it does through:

| Method | What it does |
|---|---|
| 📝 **System prompt** | Tell Qwen to ask before doing anything |
| 🏗️ **Modelfile** | Create a custom model with safety rules baked in |
| 🐳 **Docker** | Run Qwen in a container (with Ollama) for isolation |

---

## Option 1: System prompt (quickest)

Start every session with a prompt that tells Qwen not to run commands:

```bash
ollama run qwen2.5-coder:7b
```

Then type:

```
IMPORTANT: Never run shell commands. Never delete files. Always ask for confirmation
before suggesting any destructive action. Explain what you want to do and wait for
my approval before giving me commands to run.
```

Qwen will follow this for the rest of the session.

---

## Option 2: Custom Modelfile (permanent)

Create a model with safety rules baked in:

```bash
# Create a Modelfile
cat > ~/Modelfile.safety-qwen << 'EOF'
FROM qwen2.5-coder:7b

SYSTEM """
You are a coding assistant. Follow these rules strictly:

1. NEVER output shell commands that delete files, modify system settings,
   or install packages without asking first.
2. When you want to suggest a command, explain what it does and wait for
   the user to say "run it" before providing the command.
3. For file edits, show the change as a diff and ask for confirmation.
4. Never use rm -rf, sudo, chmod 777, curl | sh, or similar dangerous patterns.
"""
EOF

# Create the custom model
ollama create safety-qwen -f ~/Modelfile.safety-qwen

# Use it
ollama run safety-qwen
```

Now every session with `safety-qwen` follows those rules automatically.

---

## Option 3: Docker isolation (safest)

Run Ollama + Qwen in a container so it can't touch your real files:

```bash
# Start Ollama in Docker
docker run -d --name ollama-safe \
  -p 11435:11434 \
  ollama/ollama

# Pull Qwen inside it
docker exec ollama-safe ollama pull qwen2.5-coder:7b

# Use it (note different port)
curl http://localhost:11435/api/generate -d '{
  "model": "qwen2.5-coder:7b",
  "prompt": "Write a Python script",
  "stream": false
}'
```

---

## Summary

| Your goal | Use this |
|---|---|
| Quick, per-session | System prompt telling it to ask first |
| Permanent safety rules | Custom Modelfile with `SYSTEM` instructions |
| Complete isolation | Run Ollama in Docker |
