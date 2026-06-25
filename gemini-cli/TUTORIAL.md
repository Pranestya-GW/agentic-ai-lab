# Gemini CLI — Google AI in Terminal Tutorial

> Step-by-step guide to install and use Google's Gemini CLI with a 1M token context window.

---

### 1. Install Node.js (if not already installed)

```bash
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
node --version  # confirm it's installed (should be 20+)
```

### 2. Get a free Gemini API key

```bash
# Open https://aistudio.google.com/apikey in your browser
# Click "Create API Key"
# Copy the key: AIza...
# Free tier: 15 requests per minute
```

### 3. Set the API key permanently

```bash
echo 'export GEMINI_API_KEY="AIza-your-gemini-key-here"' >> ~/.bashrc
source ~/.bashrc
```

### 4. Verify the key is set

```bash
echo $GEMINI_API_KEY  # should show your key
```

### 5. Install Gemini CLI globally

```bash
npm install -g @google/gemini-cli
```

### 6. Verify the installation

```bash
gemini --version  # should print the installed version
gemini --help     # show available commands
```

### 7. Start interactive mode

```bash
gemini
```

### 8. Try some queries

```bash
# Inside interactive mode, type:
"Write a PostgreSQL query to find overlapping date ranges in a bookings table"

# Or one-shot from the terminal:
gemini "Explain the difference between CTE and subquery in SQL"
```

### 9. Pipe files for analysis

```bash
cat schema.sql | gemini "Check this database schema for missing indexes"
```

### 10. Use with a system prompt

```bash
gemini --prompt "You are a senior PostgreSQL DBA" "Review this query for performance issues" < slow_query.sql
```

### 11. List available models

```bash
# Gemini CLI automatically uses the best model available.
# Models you can use via your API key:
#   gemini-2.5-flash      — Fast, lightweight (1M context)
#   gemini-2.5-pro        — Complex reasoning (1M context)
#   gemini-2.5-flash-lite — Cheapest, fastest (1M context)
```

---

## Resources

- API Keys: https://aistudio.google.com/apikey
- Docs: https://ai.google.dev/gemini-api/docs
