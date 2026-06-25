#!/bin/bash
# ============================================================================
# Install pi.dev — Local AI Coding Agent
# Website: https://pi.dev
# ============================================================================
set -e

echo "Installing pi.dev coding agent..."

# ── Prerequisite checks ──────────────────────────────────────────────

# Check curl (needed for fnm install)
if ! command -v curl &>/dev/null; then
    echo "ERROR: curl is required. Install it first:"
    echo "  sudo apt-get install -y curl"
    exit 1
fi

# Check npm
if ! command -v npm &>/dev/null && ! command -v node &>/dev/null; then
    echo "Node.js/npm not found. Installing via fnm..."
    curl -fsSL https://fnm.vercel.app/install | bash
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env)"
    fnm install 22
    fnm use 22
elif command -v node &>/dev/null; then
    NODE_VER=$(node --version | sed 's/v//' | cut -d. -f1)
    if [ "$NODE_VER" -lt 18 ]; then
        echo "ERROR: Node.js $(node --version) is too old. Need 18+."
        echo "Upgrade via fnm:"
        echo "  curl -fsSL https://fnm.vercel.app/install | bash"
        echo "  fnm install 22 && fnm use 22"
        exit 1
    fi
    echo "  ✔ Node.js $(node --version)"
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
