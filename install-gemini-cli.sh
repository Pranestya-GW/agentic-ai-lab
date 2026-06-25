#!/bin/bash
# ============================================================================
# Install Gemini CLI — Google AI in Terminal
# Requires: GEMINI_API_KEY environment variable
# Get key: https://aistudio.google.com/apikey
# ============================================================================
set -e

# ── Prerequisite checks ──────────────────────────────────────────────

# Check curl
if ! command -v curl &>/dev/null; then
    echo "ERROR: curl is required. Install it first:"
    echo "  sudo apt-get install -y curl"
    exit 1
fi

# Check API key
if [ -z "$GEMINI_API_KEY" ]; then
    echo "ERROR: GEMINI_API_KEY is not set."
    echo "Get a free key at: https://aistudio.google.com/apikey"
    echo "Then run: export GEMINI_API_KEY='your-key' && ./install-gemini-cli.sh"
    exit 1
fi

# Validate API key format (Google keys start with AIza)
if [[ "$GEMINI_API_KEY" != AIza* ]]; then
    echo "WARNING: GEMINI_API_KEY doesn't start with 'AIza'. Double-check it's correct."
    echo "  Current value: ${GEMINI_API_KEY:0:12}..."
    echo "  Get key at: https://aistudio.google.com/apikey"
fi

# Test API key with a lightweight request
if command -v curl &>/dev/null; then
    echo "  Testing API key..."
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
        "https://generativelanguage.googleapis.com/v1/models?key=$GEMINI_API_KEY" 2>/dev/null || echo "000")
    if [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "403" ]; then
        echo "  ✔ API key responds (HTTP $HTTP_CODE)"
    else
        echo "WARNING: API key test returned HTTP $HTTP_CODE. Key may be invalid."
    fi
fi

echo "Installing Gemini CLI..."

# Ensure Node.js 18+
if ! command -v node &>/dev/null; then
    echo "Node.js not found. Installing via fnm..."
    curl -fsSL https://fnm.vercel.app/install | bash
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env)"
    fnm install 22
    fnm use 22
else
    NODE_VER=$(node --version | sed 's/v//' | cut -d. -f1)
    if [ "$NODE_VER" -lt 18 ]; then
        echo "ERROR: Node.js $(node --version) is too old. Need 18+."
        exit 1
    fi
    echo "  ✔ Node.js $(node --version)"
fi

# Install Gemini CLI
npm install -g @google/gemini-cli

# Persist API key
if ! grep -q "GEMINI_API_KEY" ~/.bashrc 2>/dev/null; then
    echo "export GEMINI_API_KEY=\"$GEMINI_API_KEY\"" >> ~/.bashrc
    echo "  Added GEMINI_API_KEY to ~/.bashrc"
fi

echo ""
echo "✓ Gemini CLI installed!"
echo ""
echo "Usage:"
echo "  gemini                        # Interactive mode"
echo "  gemini 'Explain this query'   # One-shot"
echo "  cat file.sql | gemini 'Optimize this'"
