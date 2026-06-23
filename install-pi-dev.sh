#!/bin/bash
# ============================================================================
# Install pi.dev — Local AI Coding Agent
# Website: https://pi.dev
# ============================================================================
set -e

echo "Installing pi.dev coding agent..."

# Ensure Node.js 20+
if ! command -v node &>/dev/null; then
    echo "Node.js not found. Installing via fnm..."
    curl -fsSL https://fnm.vercel.app/install | bash
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env)"
    fnm install 22
    fnm use 22
fi

# Install pi globally
npm install -g @earendil-works/pi-coding-agent

echo ""
echo "✓ pi.dev installed!"
echo ""
echo "Usage:"
echo "  pi                  # Start interactive session"
echo "  pi 'your query'     # One-shot query"
echo ""
echo "First run will prompt you to sign up (free)."
