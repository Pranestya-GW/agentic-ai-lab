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
