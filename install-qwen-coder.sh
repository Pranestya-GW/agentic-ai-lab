#!/bin/bash
# ============================================================================
# Install Qwen Coder — Local AI via Ollama
# Runs entirely on your machine — no API key, no internet after download.
# ============================================================================
set -e

echo "Installing Qwen Coder (via Ollama)..."

# ── Prerequisite checks ──────────────────────────────────────────────

# Check curl (needed for Ollama install)
if ! command -v curl &>/dev/null; then
    echo "ERROR: curl is required. Install it first:"
    echo "  sudo apt-get install -y curl"
    exit 1
fi

# Check available RAM
TOTAL_RAM_KB=$(grep MemTotal /proc/meminfo 2>/dev/null | awk '{print $2}' || echo "0")
TOTAL_RAM_GB=$((TOTAL_RAM_KB / 1024 / 1024))

if [ "$TOTAL_RAM_GB" -lt 8 ]; then
    echo "ERROR: Insufficient RAM for Qwen Coder."
    echo "  Detected: ${TOTAL_RAM_GB}GB"
    echo "  Minimum:  8GB (for qwen2.5-coder:7b)"
    echo "  Recommended: 16GB+"
    exit 1
elif [ "$TOTAL_RAM_GB" -lt 16 ]; then
    echo "  ⚠ RAM: ${TOTAL_RAM_GB}GB — enough for 7B model, but 14B/32B won't work"
else
    echo "  ✔ RAM: ${TOTAL_RAM_GB}GB"
fi

# Check disk space in ~/.ollama (where models are stored)
if [ -d "$HOME/.ollama" ]; then
    AVAIL_KB=$(df "$HOME/.ollama" 2>/dev/null | awk 'NR==2 {print $4}' || echo "0")
    AVAIL_GB=$((AVAIL_KB / 1024 / 1024))
    if [ "$AVAIL_GB" -lt 5 ]; then
        echo "WARNING: Only ${AVAIL_GB}GB free on disk where Ollama stores models."
        echo "  The 7B model needs ~4 GB. Consider freeing up space."
    else
        echo "  ✔ Disk space: ${AVAIL_GB}GB available"
    fi
fi

# WSL performance notice
if grep -qi microsoft /proc/version 2>/dev/null; then
    echo "  ℹ WSL detected. For better performance:"
    echo "    - Ensure WSL2: wsl --set-version Ubuntu 2"
    echo "    - Set memory limit in %USERPROFILE%\.wslconfig:"
    echo "        [wsl2]"
    echo "        memory=16GB"
    echo "        processors=8"
    echo ""
fi

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
