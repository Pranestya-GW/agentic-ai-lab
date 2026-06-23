#!/bin/bash
# ============================================================================
# Install ALL AI agents in one go
# Usage: ./install-all.sh
# ============================================================================
set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}  Agentic AI Lab — Full Install${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

# --- Node.js check ---
if ! command -v node &>/dev/null; then
    echo -e "${YELLOW}Node.js not found. Installing via fnm...${NC}"
    curl -fsSL https://fnm.vercel.app/install | bash
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env)"
    fnm install 22
    fnm use 22
fi

echo -e "${GREEN}Node.js $(node --version) ready${NC}"

# --- OpenRouter (unified API key) ---
echo -e "\n${BLUE}[0/4] Configuring OpenRouter...${NC}"
bash "$(dirname "$0")/install-openrouter.sh"

# --- pi.dev ---
echo -e "\n${BLUE}[1/4] Installing pi.dev...${NC}"
bash "$(dirname "$0")/install-pi-dev.sh" 2>/dev/null || {
    echo -e "${YELLOW}  pi.dev install skipped (check install-pi-dev.sh)${NC}"
}

# --- Gemini CLI ---
echo -e "\n${BLUE}[2/4] Installing Gemini CLI...${NC}"
if [ -n "$GEMINI_API_KEY" ]; then
    bash "$(dirname "$0")/install-gemini-cli.sh"
else
    echo -e "${YELLOW}  Skipped — set GEMINI_API_KEY env var first${NC}"
    echo "  Get key: https://aistudio.google.com/apikey"
fi

# --- Claude Code ---
echo -e "\n${BLUE}[3/4] Installing Claude Code...${NC}"
if [ -n "$ANTHROPIC_API_KEY" ]; then
    bash "$(dirname "$0")/install-claude-code.sh"
else
    echo -e "${YELLOW}  Skipped — set ANTHROPIC_API_KEY env var first${NC}"
    echo "  Get key: https://console.anthropic.com/"
fi

# --- Qwen Coder (Ollama) ---
echo -e "\n${BLUE}[4/4] Installing Qwen Coder (Ollama)...${NC}"
bash "$(dirname "$0")/install-qwen-coder.sh"

echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}  Installation Complete!${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""
echo "Installed tools:"
echo "  pi.dev:         run 'pi'"
echo "  Gemini CLI:     run 'gemini'"
echo "  Claude Code:    run 'claude'"
echo "  Qwen Coder:     run 'ollama run qwen2.5-coder:7b'"
echo ""
echo "Optional: ./install-open-webui.sh (Docker required)"
echo ""
