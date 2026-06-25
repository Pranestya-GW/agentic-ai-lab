# Open WebUI — ChatGPT-like Interface for Local Models Tutorial

> Step-by-step guide to set up a self-hosted web chat interface for Ollama models (and cloud APIs).

---

### 1. Install Docker Desktop for Windows

```bash
# Open https://www.docker.com/products/docker-desktop/ in your browser
# Download and install Docker Desktop for Windows
# After installation, launch Docker Desktop
# Wait for the Docker engine to start (whale icon stops animating)
```

### 2. Verify Docker is accessible from WSL

```bash
docker --version  # should print Docker version
docker info       # should show Docker engine is running
```

### 3. Make sure Ollama is installed and running

```bash
ollama --version           # check if Ollama is installed
ollama list                # check available models
ollama run qwen2.5-coder:7b  # pull a model if you haven't yet
```

### 4. Configure Ollama to accept Docker connections

```bash
# Ollama by default only listens on 127.0.0.1 (localhost).
# Docker containers need to access it via host.docker.internal.
sudo mkdir -p /etc/systemd/system/ollama.service.d
echo '[Service]' | sudo tee /etc/systemd/system/ollama.service.d/override.conf
echo 'Environment="OLLAMA_HOST=0.0.0.0"' | sudo tee -a /etc/systemd/system/ollama.service.d/override.conf
sudo systemctl daemon-reload
sudo systemctl restart ollama
```

### 5. Verify Ollama is now accessible on all interfaces

```bash
curl http://localhost:11434/api/tags  # should list your models
```

### 6. Run Open WebUI container

```bash
docker run -d \
  -p 3000:8080 \
  --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  --name open-webui \
  --restart always \
  ghcr.io/open-webui/open-webui:main
```

### 7. Verify the container is running

```bash
docker ps  # should show open-webui with status "Up" and port 3000->8080
```

### 8. Open Open WebUI in your browser

```bash
# Open http://localhost:3000 in your browser
# You should see the Open WebUI login/signup page
```

### 9. First-time setup

```text
1. Click "Sign Up"
2. Create an admin account (first user becomes admin)
3. After logging in, click the gear icon (Settings) in the bottom-left
4. Go to "Connections"
5. Under Ollama, set the URL to: http://host.docker.internal:11434
6. Click the refresh/save button
7. Your local models should appear
```

### 10. Start chatting with your local models

```text
1. Go back to the chat view (top-left icon or click "New Chat")
2. Select your model from the dropdown (e.g., qwen2.5-coder:7b)
3. Type your question and press Enter
4. The model runs locally — no internet needed after setup
```

### 11. Add cloud APIs (optional)

```bash
# In Settings → Connections, you can also add:
# OpenAI API:      Enter your OPENAI_API_KEY
# OpenRouter:      URL = https://openrouter.ai/api/v1  +  your key
# DeepSeek:        URL = https://api.deepseek.com/v1   +  your key (500M tokens free!)
```

### 12. Manage Docker container

```bash
# Stop the container
docker stop open-webui

# Start it again
docker start open-webui

# View logs
docker logs open-webui

# Update to latest version
docker pull ghcr.io/open-webui/open-webui:main
docker rm -f open-webui
# Then re-run the docker run command from step 6
```

---

## Resources

- GitHub: https://github.com/open-webui/open-webui
- Docs: https://docs.openwebui.com
