# AGENTS.md — Choose Your Stack

> **You decide.** This file describes every tool, plugin, and skill available in this lab.  
> Read through, pick what fits your workflow, and install only what you need.

---

## Quick Decision: Which Stack Size?

```
┌────────────────────────────────────────────────────────────────┐
│                        CHOOSE YOUR LEVEL                        │
│                                                                 │
│  🟢 LIGHT        🟡 STANDARD        🔴 FULL                    │
│  pi.dev only     + pi-setup         + all plugins & skills     │
│  + DeepSeek key  + context-mode     + web search               │
│  2 min install   5 min install      + goal mode                │
│                                  + interactive asks            │
│                                  + grilling                    │
│                                  10 min install                │
└────────────────────────────────────────────────────────────────┘
```

---

## Step-by-Step: Pick Your Tools

### 1. Choose Your AI Agent

| Agent | Type | Cost | Install | Best For |
|-------|------|------|---------|----------|
| **pi.dev** | Local agent | Free OSS | `npm install -g @earendil-works/pi-coding-agent` | Daily coding, privacy |
| **Gemini CLI** | Cloud | Pay-per-token | `npm install -g @google/gemini-cli` | 1M context, Google integration |
| **Claude Code** | Cloud | Pay-per-token | `npm install -g @anthropic-ai/claude-code` | Complex refactors |
| **Qwen Coder** | Local (Ollama) | Free | `ollama pull qwen2.5-coder:7b` | Offline/private work |

> 💡 **Recommendation:** Start with pi.dev (free, fast, private). Add cloud agents later.

---

### 2. Choose Your Model Provider

| Provider | Cost/1M tokens | Free Tier | Key Link |
|----------|---------------|-----------|----------|
| **DeepSeek** | $0.14/$0.28 (v3) | 500M tokens | [platform.deepseek.com](https://platform.deepseek.com/api_keys) |
| **OpenRouter** | Varies (200+ models) | $1 credit | [openrouter.ai/keys](https://openrouter.ai/keys) |
| **Anthropic** | $3/$15 (Sonnet) | $5 credit | [console.anthropic.com](https://console.anthropic.com/) |
| **Google AI** | $0.15/$0.60 (Flash) | 15 RPM free | [aistudio.google.com](https://aistudio.google.com/apikey) |

> 💡 **Recommendation:** DeepSeek — cheapest, 500M free tokens, `deepseek-v4-flash` is fast.

---

### 3. Decide: pi-setup (Safety + Themes)?

**pi-setup** adds a safety guard, file review, 10 themes, and token counter to pi.dev.

```
[ ] YES — install pi-setup          [ ] NO — keep vanilla pi
```

If YES:

```bash
git clone https://github.com/abhinand5/pi-setup.git ~/pi-setup
cd ~/pi-setup && ./install.sh --restore --copy-config
```

> 🛡️ Safety guard asks before `rm -rf`, `git push --force`, `sudo`, etc.

---

### 4. Pick Your Plugins

Read each description. Check the box if you want it.

#### [ ] context-mode — *Hemat Context Window*

Compresses conversation history so Pi doesn't hit the context limit during long sessions.

```bash
pi plugins install context-mode
```

**Use when:** Refactoring across many files, exploring large codebases.

**Commands:** `/context-mode on | off | smart | manual`

---

#### [ ] pi-deepseek-search — *Web Search for DeepSeek*

Gives DeepSeek models access to current web docs, APIs, npm packages, and solutions.

```bash
pi plugins install pi-deepseek-search
```

**Use when:** Working with new libraries, checking latest docs, debugging.

**Commands:** Just ask naturally — `"Search for the latest Next.js 15 API"`

---

#### [ ] pi-codex-goal — *Goal Mode*

Define a high-level objective; Pi plans and executes step-by-step.

```bash
pi plugins install pi-codex-goal
```

**Use when:** Multi-step features, migrations, scaffolding projects.

**Commands:** `/goal "Add JWT auth"` → `/goal status` → `/goal cancel`

---

#### [ ] @juicesharp/rpiv-ask-user-question — *Interactive Decisions*

Pi asks you before making architectural choices instead of guessing.

```bash
pi plugins install @juicesharp/rpiv-ask-user-question
```

**Use when:** You want full control over decisions, not auto-pilot.

**Commands:** `/ask-user-question mode always | blockers | off`

---

### 5. Pick Your Skills

#### [ ] Grilling (Matt Pocock) — *Stress-Test Plans*

Relentless interview about every aspect of your design until shared understanding.

```bash
pi skills install mattpocock/skills/grilling
```

**Use when:** Before big refactors, architecture changes, new features.

**Commands:** `"grill me on this plan"` — Pi interviews you branch by branch.

---

## Your Personalized Install Script

Check the boxes above, then copy the matching commands:

```bash
# ═══ BASE: pi.dev + DeepSeek ═══
npm install -g @earendil-works/pi-coding-agent
echo 'export DEEPSEEK_API_KEY="sk-your-key-here"' >> ~/.bashrc
source ~/.bashrc

# ═══ OPTIONAL: pi-setup ═══
# git clone https://github.com/abhinand5/pi-setup.git ~/pi-setup
# cd ~/pi-setup && ./install.sh --restore --copy-config

# ═══ OPTIONAL: Plugins ═══
# pi plugins install context-mode
# pi plugins install pi-deepseek-search
# pi plugins install pi-codex-goal
# pi plugins install @juicesharp/rpiv-ask-user-question

# ═══ OPTIONAL: Skills ═══
# pi skills install mattpocock/skills/grilling
```

> 💡 Uncomment the lines for the tools you picked above.

---

## How to Use the Full Stack

Once installed, here's your daily workflow:

```text
# ── Start pi in your project ──
cd ~/my-project
pi

# ── Inside the pi session ──
"Summarize this codebase"                           # exploration
"Find all SQL injection vulnerabilities"             # security audit
"Write tests for the authentication module"          # testing

# ── With context-mode ──
/context-mode smart
# ... long session, many files, no context loss ...

# ── With deepseek-search ──
"Search for the latest Prisma v6 migration guide and update our schema"

# ── With goal mode ──
/goal "Migrate this Express API to Fastify"
# Pi plans → you approve → Pi executes step by step

# ── With grilling ──
"I'm planning to add Redis caching — grill me on the architecture"
# Pi interviews you relentlessly until all decisions are solid
```

---

## Stack Summary

| Level | Components | Install Time |
|-------|-----------|--------------|
| 🟢 **Light** | pi.dev + DeepSeek | 2 min |
| 🟡 **Standard** | + pi-setup + context-mode | 5 min |
| 🔴 **Full** | + all plugins + grilling | 10 min |

**Start light. Add tools as you need them.**
