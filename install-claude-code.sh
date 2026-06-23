#!/bin/bash
# ============================================================================
# Install Claude Code — Anthropic AI in Terminal
# Requires: ANTHROPIC_API_KEY environment variable
# Get key: https://console.anthropic.com/
# ============================================================================
set -e

if [ -z "$ANTHROPIC_API_KEY" ]; then
    echo "ERROR: ANTHROPIC_API_KEY is not set."
    echo "Get a key at: https://console.anthropic.com/"
    echo "Then run: export ANTHROPIC_API_KEY='your-key' && ./install-claude-code.sh"
    exit 1
fi

echo "Installing Claude Code..."

# Ensure Node.js
if ! command -v node &>/dev/null; then
    curl -fsSL https://fnm.vercel.app/install | bash
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env)"
    fnm install 22
    fnm use 22
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
