# Gemini CLI — Safety Setup

> Make Gemini ask before running commands or editing files. No surprises.

---

## What you can control

| Setting | What it does |
|---|---|
| 🛡️ **Approval mode** | Ask before any tool runs (default), auto-approve edits only, or auto-approve everything |
| 📦 **Sandbox** | Run Gemini in a container so it can't touch your real files |
| ✅ **Allowed tools** | Whitelist only specific tools, block everything else |
| 💾 **Checkpointing** | Save file state before edits so you can undo |

---

## Quick setup — add to `~/.bashrc`

```bash
# Safe mode: ask before ANY tool runs (recommended)
echo 'alias gemini="gemini --approval-mode default --checkpointing"' >> ~/.bashrc
source ~/.bashrc
```

Now `gemini` will always ask before running commands or editing files.

---

## Approval modes

Pick how much freedom Gemini gets:

```bash
# Ask before every action (safest)
gemini --approval-mode default

# Auto-approve file edits, but ask for shell commands
gemini --approval-mode auto_edit

# Run everything without asking (NOT recommended)
gemini --approval-mode yolo
```

---

## Sandbox mode (safest option)

Run Gemini in a Docker container — it can't touch your real files:

```bash
gemini --sandbox
```

Everything happens inside a container. When the session ends, the container is destroyed.

---

## Allow only specific tools

Block everything except what you explicitly allow:

```bash
# Only allow reading files and listing directories
gemini --allowed-tools read_file --allowed-tools list_directory
```

---

## Settings file (permanent config)

Create `~/.gemini/settings.json`:

```json
{
  "approvalMode": "default",
  "checkpointing": true,
  "tools": {
    "sandbox": "docker.io/library/ubuntu:latest"
  }
}
```

---

## Inside a session

Once Gemini is running, approve or deny each action as it comes up. You'll see:

```
Gemini wants to run: rm -rf ./node_modules
Approve? [y/n]
```

Type `y` to allow, `n` to block.

---

## Summary

| Your goal | Use this |
|---|---|
| Ask before anything | `--approval-mode default` |
| Auto-approve edits only | `--approval-mode auto_edit` |
| Complete isolation | `--sandbox` |
| Block specific tools | `--allowed-tools read_file` |
| Undo file changes | `--checkpointing` |
