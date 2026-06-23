#!/bin/bash
# ============================================================================
# Install Open WebUI — ChatGPT-like interface for Ollama models
# Requires: Docker, Ollama running locally
# Access:   http://localhost:3000
# ============================================================================
set -e

echo "Installing Open WebUI..."

# Check Docker
if ! command -v docker &>/dev/null; then
    echo "ERROR: Docker is required. Install Docker Desktop for Windows first."
    echo "https://www.docker.com/products/docker-desktop/"
    exit 1
fi

# Check Ollama
if ! command -v ollama &>/dev/null; then
    echo "WARNING: Ollama not found. Install it first with ./install-qwen-coder.sh"
    echo "Open WebUI will start but won't have any models to chat with."
fi

# Configure Ollama to accept external connections (needed for Docker)
if systemctl is-active ollama &>/dev/null 2>&1; then
    echo "Configuring Ollama to accept Docker connections..."
    sudo mkdir -p /etc/systemd/system/ollama.service.d
    echo '[Service]' | sudo tee /etc/systemd/system/ollama.service.d/override.conf
    echo 'Environment="OLLAMA_HOST=0.0.0.0"' | sudo tee -a /etc/systemd/system/ollama.service.d/override.conf
    sudo systemctl daemon-reload
    sudo systemctl restart ollama
fi

# Stop existing container if any
docker rm -f open-webui 2>/dev/null || true

# Start Open WebUI
docker run -d \
    -p 3000:8080 \
    --add-host=host.docker.internal:host-gateway \
    -v open-webui:/app/backend/data \
    --name open-webui \
    --restart always \
    ghcr.io/open-webui/open-webui:main

echo ""
echo "✓ Open WebUI installed and running!"
echo ""
echo "  Access: http://localhost:3000"
echo ""
echo "First-time setup:"
echo "  1. Open http://localhost:3000"
echo "  2. Create an admin account"
echo "  3. Settings → Connections → Ollama API: http://host.docker.internal:11434"
echo "  4. Start chatting with your local models!"
