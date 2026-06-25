#!/bin/bash
# ============================================================================
# Configure OpenRouter — Unified API for 200+ models
# One API key → Claude, GPT, Gemini, Qwen, Llama, Mistral, and more
# Get key: https://openrouter.ai/keys
# ============================================================================
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# ── Prerequisite checks ──────────────────────────────────────────────

if [ -z "$OPENROUTER_API_KEY" ]; then
    echo -e "${YELLOW}OPENROUTER_API_KEY not set.${NC}"
    echo "Get a free key at: https://openrouter.ai/keys"
    echo ""
    echo "Then run:"
    echo "  export OPENROUTER_API_KEY='sk-or-v1-...'"
    echo "  ./install-openrouter.sh"
    echo ""
    echo -e "${BLUE}OpenRouter free tier:${NC}"
    echo "  - $1 credit on signup"
    echo "  - Access to 200+ models"
    echo "  - Pay only for tokens used"
    echo "  - No monthly fees"
    exit 0
fi

# Validate API key format (OpenRouter keys start with sk-or-v1-)
if [[ "$OPENROUTER_API_KEY" != sk-or-v1-* ]]; then
    echo -e "${YELLOW}WARNING: OPENROUTER_API_KEY doesn't start with 'sk-or-v1-'.${NC}"
    echo "  Current value: ${OPENROUTER_API_KEY:0:15}..."
    echo "  Get key at: https://openrouter.ai/keys"
fi

# Test API key with a lightweight request
if command -v curl &>/dev/null; then
    echo -e "${BLUE}  Testing API key...${NC}"
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
        -H "Authorization: Bearer $OPENROUTER_API_KEY" \
        https://openrouter.ai/api/v1/auth/key 2>/dev/null || echo "000")
    case "$HTTP_CODE" in
        200) echo -e "${GREEN}  ✔ API key is valid${NC}" ;;
        401) echo -e "${YELLOW}  ✘ API key is invalid (HTTP 401)${NC}" ;;
        000) echo -e "${YELLOW}  ⚠ Could not reach OpenRouter (no network?)${NC}" ;;
        *)   echo -e "${YELLOW}  ⚠ API returned HTTP $HTTP_CODE${NC}" ;;
    esac
fi

echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}  OpenRouter Configuration${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

# Persist API key
if ! grep -q "OPENROUTER_API_KEY" ~/.bashrc 2>/dev/null; then
    echo "export OPENROUTER_API_KEY=\"$OPENROUTER_API_KEY\"" >> ~/.bashrc
    echo -e "${GREEN}✓ Added OPENROUTER_API_KEY to ~/.bashrc${NC}"
else
    echo "  OPENROUTER_API_KEY already in ~/.bashrc"
fi

# --- Configure pi.dev for OpenRouter ---
if command -v pi &>/dev/null; then
    echo ""
    echo -e "${BLUE}Configuring pi.dev for OpenRouter...${NC}"
    echo "  pi.dev can use OpenRouter as a provider."
    echo "  Set these in pi config or run:"
    echo ""
    echo "  export OPENAI_API_KEY=\"$OPENROUTER_API_KEY\""
    echo "  export OPENAI_BASE_URL=\"https://openrouter.ai/api/v1\""
fi

# --- Configure Gemini CLI for OpenRouter (via proxy) ---
echo ""
echo -e "${BLUE}Using OpenRouter with CLI tools:${NC}"
echo ""
echo "  Many CLI tools support OpenAI-compatible endpoints."
echo "  Set these env vars to route through OpenRouter:"
echo ""
echo "  export OPENAI_API_KEY=\"$OPENROUTER_API_KEY\""
echo "  export OPENAI_BASE_URL=\"https://openrouter.ai/api/v1\""
echo ""

# --- Print cheat sheet ---
echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}  OpenRouter Model Cheat Sheet${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""
echo "  Best models via OpenRouter:"
echo ""
echo "  Provider     Model                          Cost/1M tokens"
echo "  ───────────  ─────────────────────────────  ─────────────"
echo "  Anthropic    claude-sonnet-4-20250514       $3/$15"
echo "  Google       gemini-2.5-flash               $0.15/$0.60"
echo "  Google       gemini-2.5-pro                 $1.25/$10"
echo "  OpenAI       gpt-4o                         $2.50/$10"
echo "  OpenAI       gpt-4o-mini                    $0.15/$0.60"
echo "  Meta         llama-4-maverick               $0.20/$0.90"
echo "  Alibaba      qwen-2.5-coder-32b             $0.18/$0.72"
echo "  DeepSeek     deepseek-chat-v3               \$0.89/\$1.79"
echo "  Mistral      mistral-large                  \$2/\$6"
echo ""
echo "  💡 DeepSeek also has its own API (cheaper):"
echo "     Direct:   deepseek-chat  \$0.27/\$1.10  (via https://platform.deepseek.com)"
echo "     Free:     500M tokens on signup"
echo ""
echo "  Usage in curl:"
echo "  curl https://openrouter.ai/api/v1/chat/completions \\"
echo "    -H 'Authorization: Bearer $OPENROUTER_API_KEY' \\"
echo "    -H 'Content-Type: application/json' \\"
echo "    -d '{\"model\":\"anthropic/claude-sonnet-4-20250514\",\"messages\":[{\"role\":\"user\",\"content\":\"Hello\"}]}'"
echo ""
echo -e "${GREEN}✓ OpenRouter configured!${NC}"
