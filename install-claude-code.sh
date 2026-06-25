#!/bin/bash
# ============================================================================
# Install Claude Code — Anthropic AI in Terminal
# Requires: ANTHROPIC_API_KEY environment variable
# Get key: https://console.anthropic.com/
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
if [ -z "$ANTHROPIC_API_KEY" ]; then
    echo "ERROR: ANTHROPIC_API_KEY is not set."
    echo "Get a key at: https://console.anthropic.com/"
    echo "Then run: export ANTHROPIC_API_KEY='your-key' && ./install-claude-code.sh"
    exit 1
fi

# Validate API key format (Anthropic keys start with sk-ant-)
if [[ "$ANTHROPIC_API_KEY" != sk-ant-* ]]; then
    echo "WARNING: ANTHROPIC_API_KEY doesn't start with 'sk-ant-'. Double-check it's correct."
    echo "  Current value: ${ANTHROPIC_API_KEY:0:15}..."
    echo "  Get key at: https://console.anthropic.com/"
fi

echo "Installing Claude Code..."

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

# Install Claude Code CLI
npm install -g @anthropic-ai/claude-code

# Persist API key
if ! grep -q "ANTHROPIC_API_KEY" ~/.bashrc 2>/dev/null; then
    echo "export ANTHROPIC_API_KEY=\"$ANTHROPIC_API_KEY\"" >> ~/.bashrc
    echo "  Added ANTHROPIC_API_KEY to ~/.bashrc"
fi

echo ""
echo "✓ Claude Code installed!"
echo ""
echo "Usage:"
echo "  claude                                    # Interactive mode"
echo "  claude 'Write a Python ETL script'        # One-shot"
echo "  claude --file schema.sql 'Add indexes'    # With file context"
