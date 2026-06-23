# Claude Code — Anthropic in Terminal

> Anthropic's agentic coding tool. Excels at complex refactoring, large-scale code changes, and deep reasoning tasks.

## Quick Start

### API Key Setup

```bash
# Get key: https://console.anthropic.com/
# Or OpenRouter: https://openrouter.ai/keys  (one key for all)
# Or DeepSeek: https://platform.deepseek.com/api_keys  (500M free tokens)

# Temporary (this session only)
export ANTHROPIC_API_KEY="sk-ant-..."

# Permanent (add to ~/.bashrc)
echo 'export ANTHROPIC_API_KEY="sk-ant-..."' >> ~/.bashrc
source ~/.bashrc

# Or use OpenRouter as unified provider
export OPENROUTER_API_KEY="sk-or-v1-..."
export ANTHROPIC_API_KEY="$OPENROUTER_API_KEY"
```

### Install

```bash
npm install -g @anthropic-ai/claude-code

# Run
claude
```

## Key Features

- **200K context window** — handles large files and codebases
- **Agentic** — plans multi-step tasks, executes commands
- **Git-aware** — understands commits, diffs, branches
- **File editing** — makes precise code changes
- **Bash execution** — runs tests, builds, deployments

## Daily Workflow Examples

```bash
# Interactive mode
claude

# Major refactor
claude "Refactor the database layer to use connection pooling"

# Code review
claude "Review the changes in the last commit for bugs"

# Test generation
claude "Write unit tests for the scanner module"

# Documentation
claude "Generate API documentation from the codebase"

# With specific file context
claude --file schema.sql "Add proper indexes to this schema"

# Debug with git context
claude "The tests broke after the last commit. Find and fix the issue."
```

## Models

| Model | Best For |
|-------|----------|
| `claude-sonnet-4-20250514` | Daily coding, fast responses |
| `claude-opus-4-20250514` | Complex reasoning, large refactors |

## Resources

- API keys: https://console.anthropic.com/
- Docs: https://docs.anthropic.com/en/docs/claude-code
