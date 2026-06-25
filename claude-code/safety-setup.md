# Claude Code — Safety Setup

> Make Claude ask permission before running commands, editing files, or touching your system.

---

## Built-in permission system

Claude Code has a permission system built right in. No extra installs needed.

| What you can control | How |
|---|---|
| 🔒 **Permission mode** | Ask before actions, auto-approve edits, or plan-only mode |
| 📁 **`.claude/settings.json`** | Project-level rules for what Claude can and can't do |
| `/permissions` | Change permission mode mid-session |
| 🚫 **Block rules** | Never allow specific commands or paths |

---

## Quick setup — add to `~/.bashrc`

```bash
# Always ask before running anything (recommended)
alias claude='claude --permission-mode default'
```

---

## Permission modes

```bash
# Ask before every tool use (safest, default)
claude --permission-mode default

# Auto-approve file edits, ask for shell commands
claude --permission-mode acceptEdits

# Read and plan only — no edits, no commands (safest for review)
claude --permission-mode plan

# Run everything without asking (NOT recommended)
claude --permission-mode bypassPermissions
```

---

## Project settings — `.claude/settings.json`

Put this in your project folder to enforce rules:

```json
{
  "permissions": {
    "allow": [
      "Bash(npm test:*)",
      "Bash(git diff:*)",
      "Bash(git status:*)",
      "Read(*)",
      "Edit(*)"
    ],
    "deny": [
      "Bash(rm:*)",
      "Bash(sudo:*)",
      "Bash(curl:*)",
      "Bash(wget:*)"
    ]
  }
}
```

This lets Claude read/edit files and run `npm test`, `git diff`, and `git status` — but blocks delete, sudo, and network calls.

---

## Inside a session

Switch modes anytime:

```
/permissions              # see current mode
/permissions acceptEdits  # switch to auto-approve edits
/permissions default      # switch back to ask-everything
```

---

## Summary

| Your goal | Use this |
|---|---|
| Ask before anything | `claude --permission-mode default` |
| Auto-approve edits only | `claude --permission-mode acceptEdits` |
| Read-only, no changes | `claude --permission-mode plan` |
| Block dangerous commands | `.claude/settings.json` with `deny` rules |
