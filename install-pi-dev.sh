#!/bin/bash
# ============================================================================
# Install pi.dev — Local AI Coding Agent + Recommended Stack
# Website: https://pi.dev
# ============================================================================
set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}  pi.dev Installer${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

# ── Prerequisite checks ──────────────────────────────────────────────

# Check curl (needed for fnm install)
if ! command -v curl &>/dev/null; then
    echo -e "${RED}ERROR: curl is required. Install it first:${NC}"
    echo "  sudo apt-get install -y curl"
    exit 1
fi

# Check npm / Node.js
if ! command -v npm &>/dev/null && ! command -v node &>/dev/null; then
    echo -e "${YELLOW}Node.js/npm not found. Installing via fnm...${NC}"
    curl -fsSL https://fnm.vercel.app/install | bash
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env)"
    fnm install 22
    fnm use 22
elif command -v node &>/dev/null; then
    NODE_VER=$(node --version | sed 's/v//' | cut -d. -f1)
    if [ "$NODE_VER" -lt 18 ]; then
        echo -e "${RED}ERROR: Node.js $(node --version) is too old. Need 18+.${NC}"
        echo "Upgrade via fnm:"
        echo "  curl -fsSL https://fnm.vercel.app/install | bash"
        echo "  fnm install 22 && fnm use 22"
        exit 1
    fi
    echo -e "  ${GREEN}✔${NC} Node.js $(node --version)"
fi

# ── Install pi binary ────────────────────────────────────────────────

echo ""
echo -e "${BLUE}Installing pi.dev binary...${NC}"
npm install -g @earendil-works/pi-coding-agent

echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}  pi.dev installed!${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""
echo "Usage:"
echo "  pi                  # Start interactive session"
echo "  pi 'your query'     # One-shot query"
echo ""
echo "First run will prompt you to sign up (free)."
echo ""

# ── Recommended Stack Menu ───────────────────────────────────────────

echo -e "${BLUE}────────────────────────────────────────────${NC}"
echo -e "${BLUE}  Recommended pi.dev Stack${NC}"
echo -e "${BLUE}────────────────────────────────────────────${NC}"
echo ""
echo -e "This adds:"
echo -e "  ${CYAN}pi-setup${NC}         — safety guard, themes, file review"
echo -e "  ${CYAN}DeepSeek key${NC}      — cheapest model provider (500M free tokens)"
echo -e "  ${CYAN}context-mode${NC}      — hemat context window"
echo -e "  ${CYAN}deepseek-search${NC}   — web search for DeepSeek"
echo -e "  ${CYAN}codex-goal${NC}        — goal-oriented mode"
echo -e "  ${CYAN}ask-user-question${NC} — interactive confirmations"
echo -e "  ${CYAN}grilling skill${NC}    — stress-test your plans"
echo ""
echo -e "  ${GREEN}[A]${NC} Install EVERYTHING — full stack, ~5 min"
echo -e "  ${YELLOW}[C]${NC} Choose individually — pick what you want"
echo -e "  ${RED}[N]${NC} Skip — just pi.dev, nothing else"
echo ""

read -p "Your choice [A/C/N]: " STACK_CHOICE
echo ""

case "$(echo "$STACK_CHOICE" | tr '[:upper:]' '[:lower:]')" in
  a)
    INSTALL_PI_SETUP=true
    INSTALL_DEEPSEEK=true
    INSTALL_CONTEXT_MODE=true
    INSTALL_DEEPSEEK_SEARCH=true
    INSTALL_CODEX_GOAL=true
    INSTALL_ASK_USER=true
    INSTALL_GRILLING=true
    echo -e "${GREEN}▶ Installing full stack...${NC}"
    ;;

  c)
    echo -e "${BLUE}Pick components to install:${NC}"
    echo ""

    read -p "  pi-setup (safety guard, themes, file review)?            [y/N] " yn
    case "$yn" in [Yy]*) INSTALL_PI_SETUP=true ;; esac

    read -p "  DeepSeek provider key?                                    [y/N] " yn
    case "$yn" in [Yy]*) INSTALL_DEEPSEEK=true ;; esac

    read -p "  context-mode plugin (hemat context window)?               [y/N] " yn
    case "$yn" in [Yy]*) INSTALL_CONTEXT_MODE=true ;; esac

    read -p "  pi-deepseek-search plugin (web search)?                   [y/N] " yn
    case "$yn" in [Yy]*) INSTALL_DEEPSEEK_SEARCH=true ;; esac

    read -p "  pi-codex-goal plugin (goal mode)?                         [y/N] " yn
    case "$yn" in [Yy]*) INSTALL_CODEX_GOAL=true ;; esac

    read -p "  rpiv-ask-user-question plugin (interactive decisions)?    [y/N] " yn
    case "$yn" in [Yy]*) INSTALL_ASK_USER=true ;; esac

    read -p "  Grilling skill (stress-test plans)?                       [y/N] " yn
    case "$yn" in [Yy]*) INSTALL_GRILLING=true ;; esac

    echo ""

    if [ -z "$INSTALL_PI_SETUP$INSTALL_DEEPSEEK$INSTALL_CONTEXT_MODE$INSTALL_DEEPSEEK_SEARCH$INSTALL_CODEX_GOAL$INSTALL_ASK_USER$INSTALL_GRILLING" ]; then
        echo -e "${YELLOW}Nothing selected. Skipping stack.${NC}"
        echo ""
        echo "You can install stack components later — see:"
        echo "  pi-dev/pi-setup.md"
        echo "  AGENTS.md"
        echo ""
        exit 0
    fi
    echo -e "${GREEN}▶ Installing selected components...${NC}"
    ;;

  *)
    echo -e "${YELLOW}Skipping stack. Run 'pi' to start coding.${NC}"
    echo ""
    echo "You can install stack components later — see:"
    echo "  pi-dev/pi-setup.md"
    echo "  AGENTS.md"
    echo ""
    exit 0
    ;;
esac

echo ""

# ── Step 1: pi-setup ─────────────────────────────────────────────────
if [ -n "$INSTALL_PI_SETUP" ]; then
    echo -e "${CYAN}[1/7] Installing pi-setup...${NC}"

    if ! command -v git &>/dev/null; then
        echo -e "${RED}  ✘ git not found — skipping pi-setup.${NC}"
        echo "    Install git: sudo apt-get install -y git"
    elif [ -d "$HOME/pi-setup" ]; then
        echo -e "  ${YELLOW}⚠${NC} ~/pi-setup already exists — pulling latest..."
        (cd "$HOME/pi-setup" && git pull 2>/dev/null) || true
        (cd "$HOME/pi-setup" && ./install.sh --restore --copy-config 2>/dev/null) || {
            echo -e "  ${YELLOW}⚠${NC} pi-setup install failed — skipping"
        }
    else
        git clone https://github.com/abhinand5/pi-setup.git "$HOME/pi-setup" 2>/dev/null && {
            cd "$HOME/pi-setup"
            ./install.sh --restore --copy-config 2>/dev/null && \
                echo -e "  ${GREEN}✔${NC} pi-setup installed" || \
                echo -e "  ${YELLOW}⚠${NC} pi-setup install failed — skipping"
        } || {
            echo -e "  ${YELLOW}⚠${NC} Failed to clone pi-setup — skipping"
        }
    fi
fi

# ── Step 2: DeepSeek key ─────────────────────────────────────────────
if [ -n "$INSTALL_DEEPSEEK" ]; then
    echo -e "${CYAN}[2/7] Setting up DeepSeek provider...${NC}"

    if [ -n "$DEEPSEEK_API_KEY" ]; then
        echo -e "  ${GREEN}✔${NC} DEEPSEEK_API_KEY already set"
    else
        echo -e "  ${YELLOW}ℹ${NC}  Get your free key: https://platform.deepseek.com/api_keys"
        echo ""
        read -sp "  Paste your DeepSeek API key (input hidden): " DEEPSEEK_KEY
        echo ""

        if [ -n "$DEEPSEEK_KEY" ]; then
            echo "export DEEPSEEK_API_KEY=\"$DEEPSEEK_KEY\"" >> "$HOME/.bashrc"
            export DEEPSEEK_API_KEY="$DEEPSEEK_KEY"
            echo -e "  ${GREEN}✔${NC} DeepSeek key saved to ~/.bashrc"
        else
            echo -e "  ${YELLOW}⚠${NC}  No key entered — add manually later:"
            echo "    echo 'export DEEPSEEK_API_KEY=\"sk-...\"' >> ~/.bashrc"
        fi
    fi

    echo "  Docs:      https://api-docs.deepseek.com/"
    echo "  API Base:  https://api.deepseek.com/v1"
    echo "  Model:     deepseek-v4-flash"
fi

# ── Step 3: context-mode ─────────────────────────────────────────────
if [ -n "$INSTALL_CONTEXT_MODE" ]; then
    echo -e "${CYAN}[3/7] Installing context-mode plugin...${NC}"
    pi plugins install context-mode 2>/dev/null && \
        echo -e "  ${GREEN}✔${NC} context-mode installed" || \
        echo -e "  ${YELLOW}⚠${NC} context-mode install failed — try manually: pi plugins install context-mode"
    echo "  Usage: /context-mode on | off | smart | manual"
fi

# ── Step 4: pi-deepseek-search ───────────────────────────────────────
if [ -n "$INSTALL_DEEPSEEK_SEARCH" ]; then
    echo -e "${CYAN}[4/7] Installing pi-deepseek-search plugin...${NC}"
    pi plugins install pi-deepseek-search 2>/dev/null && \
        echo -e "  ${GREEN}✔${NC} pi-deepseek-search installed" || \
        echo -e "  ${YELLOW}⚠${NC} pi-deepseek-search install failed — try manually"
    echo "  Usage: 'Search for the latest React 19 API'"
fi

# ── Step 5: pi-codex-goal ────────────────────────────────────────────
if [ -n "$INSTALL_CODEX_GOAL" ]; then
    echo -e "${CYAN}[5/7] Installing pi-codex-goal plugin...${NC}"
    pi plugins install pi-codex-goal 2>/dev/null && \
        echo -e "  ${GREEN}✔${NC} pi-codex-goal installed" || \
        echo -e "  ${YELLOW}⚠${NC} pi-codex-goal install failed — try manually"
    echo "  Usage: /goal 'Add JWT auth to this app'"
fi

# ── Step 6: rpiv-ask-user-question ───────────────────────────────────
if [ -n "$INSTALL_ASK_USER" ]; then
    echo -e "${CYAN}[6/7] Installing rpiv-ask-user-question plugin...${NC}"
    pi plugins install @juicesharp/rpiv-ask-user-question 2>/dev/null && \
        echo -e "  ${GREEN}✔${NC} rpiv-ask-user-question installed" || \
        echo -e "  ${YELLOW}⚠${NC} rpiv-ask-user-question install failed — try manually"
    echo "  Usage: /ask-user-question mode always | blockers | off"
fi

# ── Step 7: Grilling skill ───────────────────────────────────────────
if [ -n "$INSTALL_GRILLING" ]; then
    echo -e "${CYAN}[7/7] Installing grilling skill...${NC}"
    pi skills install mattpocock/skills/grilling 2>/dev/null && \
        echo -e "  ${GREEN}✔${NC} Grilling skill installed" || \
        echo -e "  ${YELLOW}⚠${NC} Grilling skill install failed — try manually"
    echo "  Usage: 'grill me on this architecture'"
fi

# ── Done ─────────────────────────────────────────────────────────────

echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}  Done! Your pi.dev setup:${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""
echo "  pi.dev binary:    ✓"
[ -n "$INSTALL_PI_SETUP" ]        && echo "  pi-setup:         ✓ (safety, themes, file review)"
[ -n "$INSTALL_DEEPSEEK" ]        && echo "  DeepSeek key:     ✓"
[ -n "$INSTALL_CONTEXT_MODE" ]    && echo "  context-mode:     ✓"
[ -n "$INSTALL_DEEPSEEK_SEARCH" ] && echo "  deepseek-search:  ✓"
[ -n "$INSTALL_CODEX_GOAL" ]      && echo "  codex-goal:       ✓"
[ -n "$INSTALL_ASK_USER" ]        && echo "  ask-user-question: ✓"
[ -n "$INSTALL_GRILLING" ]        && echo "  grilling skill:   ✓"
echo ""
echo "Start coding:"
echo "  cd ~/my-project"
echo "  pi"
echo ""
