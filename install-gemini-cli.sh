#!/bin/bash
# ============================================================================
# Install Gemini CLI — Google AI in Terminal
# Requires: GEMINI_API_KEY environment variable
# Get key: https://aistudio.google.com/apikey
# ============================================================================
set -e

if [ -z "$GEMINI_API_KEY" ]; then
    echo "ERROR: GEMINI_API_KEY is not set."
    echo "Get a free key at: https://aistudio.google.com/apikey"
    echo "Then run: export GEMINI_API_KEY='your-key' && ./install-gemini-cli.sh"
    exit 1
fi

echo "Installing Gemini CLI..."

# Ensure Node.js
if ! command -v node &>/dev/null; then
    curl -fsSL https://fnm.vercel.app/install | bash
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env)"
    fnm install 22
    fnm use 22
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
