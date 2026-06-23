#!/bin/bash
# ============================================================================
# Install Qwen Coder — Local AI via Ollama
# Runs entirely on your machine — no API key, no internet after download.
# ============================================================================
set -e

echo "Installing Qwen Coder (via Ollama)..."

# --- Install Ollama ---
if ! command -v ollama &>/dev/null; then
    echo "Installing Ollama..."
    curl -fsSL https://ollama.com/install.sh | sh
else
    echo "Ollama already installed: $(ollama --version)"
fi

# --- Pull Qwen 2.5 Coder models ---
echo ""
echo "Pulling Qwen 2.5 Coder models..."

echo "  Pulling qwen2.5-coder:7b (~4 GB)..."
ollama pull qwen2.5-coder:7b

# Optional larger models (uncomment if you have enough RAM)
# echo "  Pulling qwen2.5-coder:14b (~9 GB)..."
# ollama pull qwen2.5-coder:14b

echo ""
echo "✓ Qwen Coder installed!"
echo ""
echo "Usage:"
echo "  ollama run qwen2.5-coder:7b                     # Interactive chat"
echo "  ollama run qwen2.5-coder:7b 'Write a SQL query' # One-shot"
echo ""
echo "API (for programmatic use):"
echo "  curl http://localhost:11434/api/generate -d '{\"model\":\"qwen2.5-coder:7b\",\"prompt\":\"...\"}'"
echo ""
echo "Model sizes available:"
echo "  qwen2.5-coder:7b   (~4 GB) — Fast, good for simple tasks"
echo "  qwen2.5-coder:14b  (~9 GB) — Better, needs 16GB RAM"
echo "  qwen2.5-coder:32b  (~20GB) — Best, needs 32GB RAM"
