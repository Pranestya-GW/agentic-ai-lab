# pi-setup — Make Pi Better

> pi-setup adds safety checks, file review tools, themes, and other goodies to your Pi coding agent. One command to install, easy to undo.

---

## What does it add?

| You get | What it does |
|---|---|
| 🔒 **Safety guard** | Asks before running dangerous commands (force push, delete, sudo, etc.) |
| 📝 **File review** | Shows every file Pi changed — accept or undo with one command |
| 🎨 **10 themes** | Switch how Pi looks (dracula, nord, tokyo-night, etc.) |
| 📊 **Token counter** | See how much context you're using in real time |
| 🤖 **Local models** | Connect Ollama or LM Studio models to Pi |
| 🔄 **Sync backup** | Save your Pi setup to GitHub with one command |

---

## How to install

### What you need first
- Pi CLI installed: `npm install -g @earendil-works/pi-coding-agent`
- Git installed

### Install (copy-paste these 3 lines)

```bash
git clone https://github.com/abhinand5/pi-setup.git ~/pi-setup
cd ~/pi-setup
./install.sh --restore --copy-config
```

That's it. All the extensions, themes, and tools are now in your Pi.

---

## ⚠️ One fix you might need

After installing, you might see this warning:

```
Warning: no existing Pi binary found
```

This just means pi-setup can't find the real Pi. Fix it with 2 commands:

```bash
# 1. Tell it where the real Pi lives
echo 'export PI_REAL_BIN=$HOME/.local/share/fnm/node-versions/v22.14.0/installation/bin/pi' >> ~/.bashrc

# 2. Reload
source ~/.bashrc
```

Now `pi --version` should work normally.

---

## New commands you can use inside Pi

| Type this | What happens |
|---|---|
| `/filechanges` | See every file Pi changed, with before/after diffs |
| `/filechanges-accept` | Keep all the changes Pi made |
| `/filechanges-decline` | Undo all the changes Pi made |
| `/safety` | Check if safety guard is on or off |
| `/context` | See how much of your context window is used |
| `/local-models` | Add a local model from Ollama or LM Studio |
| `/welcome updates on` | Turn on update notices on startup |

---

## Backing up your setup to GitHub

Changed themes, added extensions? Save it all:

```bash
cd ~/pi-setup
pi-setup-sync
```

This copies your Pi config → commits it → pushes to GitHub. Next time you're on another computer, just clone and run `./install.sh --restore` to get everything back.

---

## Removing pi-setup

Want to go back to plain Pi? This removes only what pi-setup added:

```bash
cd ~/pi-setup
./uninstall.sh
```

Your Pi CLI is untouched — it's still there, just without the extras.

---

## What's actually installed?

**Extensions** (live in `~/.pi/agent/extensions/`):
- Safety guard — confirms before dangerous commands
- File changes — track and review every edit Pi makes
- Token footer — shows usage, cost, model name
- Context viewer — see what's filling your context window
- Local model manager — connect local LLMs

**Themes** (switch with `/theme`):
`nebula-pulse`, `tokyo-night`, `one-dark-pro`, `dracula`, `catppuccin`, `nord`, `gruvbox`, `rose-pine`, `synthwave-84`, `opencode`

---

# 🚀 Complete Recommended Stack

> Beyond pi-setup: install DeepSeek as provider, power-up plugins, and the grilling skill. One script to rule them all.

---

## One-Command Install (pi-setup-git)

Copy-paste this block to install **everything** — pi-setup + DeepSeek + all plugins + skills:

```bash
# ═══════════════════════════════════════════════════════════
# pi-setup-git: Complete pi.dev Recommended Stack Installer
# ═══════════════════════════════════════════════════════════

# ── Step 1: pi-setup (safety guard, themes, file review) ──
git clone https://github.com/abhinand5/pi-setup.git ~/pi-setup
cd ~/pi-setup
./install.sh --restore --copy-config

# ── Step 2: Set DeepSeek as default provider ──
echo 'export DEEPSEEK_API_KEY="sk-your-key-here"' >> ~/.bashrc
source ~/.bashrc

# ── Step 3: Install recommended plugins ──
pi plugins install context-mode                          # hemat context window
pi plugins install pi-deepseek-search                    # web search for DeepSeek
pi plugins install pi-codex-goal                         # goal-oriented mode
pi plugins install @juicesharp/rpiv-ask-user-question    # interactive confirmations

# ── Step 4: Install the grilling skill ──
pi skills install mattpocock/skills/grilling

echo "✅ Complete stack installed!"
```

---

## What Each Stack Component Does

### 🧠 Provider: DeepSeek

| Setting | Value |
|---------|-------|
| **API Docs** | https://api-docs.deepseek.com/ |
| **API Base** | https://api.deepseek.com/v1 |
| **Default Model** | `deepseek-v4-flash` |
| **Free Tier** | 500M tokens on signup |
| **Key** | https://platform.deepseek.com/api_keys |

**Why DeepSeek?** Cheapest coding model, 500M free tokens at signup, and `deepseek-v4-flash` is fast + good for daily coding tasks.

**How to use:**

```bash
# One-shot with DeepSeek model
pi --model deepseek-v4-flash "Explain this codebase"

# Permanent default — add to ~/.bashrc
export DEEPSEEK_API_KEY="sk-..."

# Switch models mid-session
/model deepseek-v4-flash
```

---

### 🔌 Plugin: context-mode

> Hemat context window — compresses conversation history so Pi doesn't forget earlier context.

**Install:** `pi plugins install context-mode`
**Docs:** https://pi.dev/packages/context-mode

**How to use:**

```text
# Inside pi session:
/context-mode on       # Enable context compression
/context-mode off      # Disable (full context)
/context-mode status   # Check current mode

# Modes available:
#   smart   — auto-compress when context fills up
#   manual  — compress only when you say so
#   off     — raw context, fastest but limited window
```

**When to use:** Long refactoring sessions, multi-file changes, exploring unknown codebases.

---

### 🔌 Plugin: pi-deepseek-search

> Biar DeepSeek bisa web search — gives DeepSeek models internet access for current docs, APIs, and solutions.

**Install:** `pi plugins install pi-deepseek-search`
**Docs:** https://pi.dev/packages/pi-deepseek-search

**How to use:**

```text
# Inside pi session — just ask naturally:
"Search for the latest React 19 API changes and update our hooks"
"Find the npm package for PostgreSQL connection pooling and add it"
"Look up how to configure Tailwind v4 with Vite"

# Explicit search command:
/search "Python 3.12 asyncio improvements"
```

**When to use:** Working with new libraries, checking latest docs, debugging with StackOverflow solutions.

---

### 🔌 Plugin: pi-codex-goal

> Goal mode — define a high-level objective and let Pi plan + execute step by step.

**Install:** `pi plugins install pi-codex-goal`
**Docs:** https://pi.dev/packages/pi-codex-goal

**How to use:**

```text
# Inside pi session:
/goal "Add user authentication with JWT to this Express app"
/goal "Migrate this project from JavaScript to TypeScript"
/goal "Set up CI/CD with GitHub Actions for this repo"

# Pi will:
#   1. Break the goal into subtasks
#   2. Show you the plan
#   3. Execute step by step, asking for confirmation
#   4. Stop if it hits a blocker

# Check progress:
/goal status

# Abort:
/goal cancel
```

**When to use:** Multi-step features, migrations, scaffolding new projects.

---

### 🔌 Plugin: @juicesharp/rpiv-ask-user-question

> Interactive ask-user-question — Pi will ask you for decisions instead of guessing.

**Install:** `pi plugins install @juicesharp/rpiv-ask-user-question`
**Docs:** https://pi.dev/packages/@juicesharp/rpiv-ask-user-question

**How to use:**

```text
# Plugin activates automatically. Pi will ask you:
#   "Should I use PostgreSQL or SQLite for this?"
#   "Which port should the dev server run on? (default: 3000)"
#   "Keep the existing error handling or rewrite?"

# You'll see interactive prompts:
#   [1] Option A
#   [2] Option B
#   [3] Custom answer...

# Configure:
/ask-user-question mode always    # Ask for every decision
/ask-user-question mode blockers   # Only ask when blocked
/ask-user-question mode off        # Disable, let Pi guess
```

**When to use:** When you want full control over architectural decisions, not auto-pilot.

---

### 🎯 Skill: Grilling (Matt Pocock)

> Stress-test your plans and designs through relentless Q&A.

**Install:** `pi skills install mattpocock/skills/grilling`
**Docs:** https://www.skills.sh/mattpocock/skills/grilling

**How to use:**

```text
# Inside pi session — trigger with 'grill me':
"I want to add Redis caching to the API — grill me"
"Here's my database schema plan — grill me on it"

# What happens:
#   Pi interviews you relentlessly about every aspect
#   Walks down each branch of the decision tree
#   Stops when all decisions are resolved
#   Result: crystal-clear shared understanding
```

**When to use:** Before big refactors, architectural changes, new feature planning — anything where getting it wrong is expensive.

---

## Stack Decision Guide

| You want... | Install these |
|-------------|--------------|
| **Minimal** (just code) | pi.dev + DeepSeek key |
| **Daily driver** | + pi-setup + context-mode |
| **Web-aware coding** | + pi-deepseek-search |
| **Project scaffolding** | + pi-codex-goal |
| **Full control** | + rpiv-ask-user-question |
| **Architecture planning** | + grilling skill |
| **The whole kitchen sink** | `pi-setup-git` (all of the above) |
