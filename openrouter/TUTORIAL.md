# OpenRouter — Unified API for 200+ Models Tutorial

> Step-by-step guide to set up OpenRouter, a single API key gateway to Claude, GPT, Gemini, Qwen, Llama, and more.

---

### 1. Create an OpenRouter account and get your API key

```bash
# Go to https://openrouter.ai/keys in your browser
# Sign up (free — comes with $1 credit)
# Create a new API key
# Copy the key: sk-or-v1-...
```

### 2. Set the API key permanently

```bash
echo 'export OPENROUTER_API_KEY="sk-or-v1-your-key-here"' >> ~/.bashrc
source ~/.bashrc
```

### 3. Verify the key is set

```bash
echo $OPENROUTER_API_KEY  # should show your key
```

### 4. Test the API with a simple curl request

```bash
curl https://openrouter.ai/api/v1/chat/completions \
  -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "google/gemini-2.5-flash",
    "messages": [{"role": "user", "content": "Say hello in 5 words"}]
  }'
```

### 5. Use OpenRouter as an OpenAI-compatible provider

```bash
# Set these environment variables to route any OpenAI-compatible tool through OpenRouter
export OPENAI_API_KEY="$OPENROUTER_API_KEY"
export OPENAI_BASE_URL="https://openrouter.ai/api/v1"

# Now tools that use OPENAI_API_KEY will work with any OpenRouter model
```

### 6. Test with Python (if you have Python installed)

```bash
python3 -c "
from openai import OpenAI
client = OpenAI(
    base_url='https://openrouter.ai/api/v1',
    api_key='$OPENROUTER_API_KEY',
)
response = client.chat.completions.create(
    model='google/gemini-2.5-flash',
    messages=[{'role': 'user', 'content': 'Write a SQL query to find duplicate emails'}],
)
print(response.choices[0].message.content)
"
```

### 7. Browse available models

```bash
# Open https://openrouter.ai/models in your browser
# Filter by: coding, cheapest, fastest, etc.
```

### 8. Recommended models for coding

```bash
# Best code quality:      anthropic/claude-sonnet-4-20250514  ($3/$15 per 1M tokens)
# Cheapest good:          google/gemini-2.5-flash            ($0.15/$0.60)
# Budget open-source:     deepseek/deepseek-chat-v3          ($0.89/$1.79)
# Local alternative:      qwen/qwen-2.5-coder-32b            ($0.18/$0.72)
```

---

## Resources

- API Keys: https://openrouter.ai/keys
- Models: https://openrouter.ai/models
- Docs: https://openrouter.ai/docs
