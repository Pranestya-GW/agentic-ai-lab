# OpenRouter — Unified API for 200+ Models

> One API key to access Claude, GPT, Gemini, Qwen, Llama, Mistral, DeepSeek, and more. Pay per token — no monthly fees.

## Why OpenRouter?

Instead of managing 5 different API keys and billing accounts:

```
Before:                          After:
ANTHROPIC_API_KEY=sk-ant-...     OPENROUTER_API_KEY=sk-or-v1-...
GEMINI_API_KEY=AIza...           ↓
OPENAI_API_KEY=sk-...            Claude + GPT + Gemini + Qwen + Llama + ...
```

## Quick Start

```bash
# Get key: https://openrouter.ai/keys

# Temporary (this session only)
export OPENROUTER_API_KEY="sk-or-v1-..."

# Permanent (add to ~/.bashrc)
echo 'export OPENROUTER_API_KEY="sk-or-v1-..."' >> ~/.bashrc
source ~/.bashrc

# Configure
./install-openrouter.sh
```

## Using OpenRouter with Existing Tools

### pi.dev

```bash
# Set as OpenAI-compatible provider
export OPENAI_API_KEY="$OPENROUTER_API_KEY"
export OPENAI_BASE_URL="https://openrouter.ai/api/v1"
pi
```

### Any OpenAI-compatible CLI

```bash
# Works with most tools that accept OPENAI_API_KEY
export OPENAI_API_KEY="$OPENROUTER_API_KEY"
export OPENAI_BASE_URL="https://openrouter.ai/api/v1"
```

### Direct curl

```bash
curl https://openrouter.ai/api/v1/chat/completions \
  -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "anthropic/claude-sonnet-4-20250514",
    "messages": [{"role": "user", "content": "Write a PostgreSQL query"}]
  }'
```

### Python

```python
from openai import OpenAI

client = OpenAI(
    base_url="https://openrouter.ai/api/v1",
    api_key="sk-or-v1-...",
)

response = client.chat.completions.create(
    model="google/gemini-2.5-flash",
    messages=[{"role": "user", "content": "Explain this query"}],
)
print(response.choices[0].message.content)
```

## Best Models by Task

| Task | Recommended Model | Cost/1M |
|------|-------------------|---------|
| **Best code** | `anthropic/claude-sonnet-4-20250514` | $3/$15 |
| **Cheapest good** | `google/gemini-2.5-flash` | $0.15/$0.60 |
| **Fast & capable** | `google/gemini-2.5-pro` | $1.25/$10 |
| **Local alternative** | `qwen/qwen-2.5-coder-32b` | $0.18/$0.72 |
| **Open-source best** | `meta-llama/llama-4-maverick` | $0.20/$0.90 |
| **Reasoning** | `anthropic/claude-opus-4-20250514` | $15/$75 |
| **Long context** | `google/gemini-2.5-pro` (1M ctx) | $1.25/$10 |
| **Budget coding** | `deepseek/deepseek-chat-v3` | $0.89/$1.79 |

> 💡 **DeepSeek also has its own API** (cheaper than via OpenRouter):  
> Direct `deepseek-chat` at **$0.27/$1.10** per 1M tokens + **500M tokens free** on signup.  
> Get key: [platform.deepseek.com/api_keys](https://platform.deepseek.com/api_keys)

## OpenRouter vs Direct APIs

| Aspect | OpenRouter | Direct API |
|--------|-----------|------------|
| **Setup** | 1 key | 5+ keys |
| **Billing** | 1 bill | Multiple bills |
| **Model choice** | 200+ models | Per-provider |
| **Rate limits** | Pooled | Per-provider |
| **Privacy** | Zero-log by default | Per-provider policy |
| **Cost** | Same as direct | Same as direct |
| **Free tier** | $1 credit | Per-provider |

## Resources

- Keys: https://openrouter.ai/keys
- Models: https://openrouter.ai/models
- Docs: https://openrouter.ai/docs
