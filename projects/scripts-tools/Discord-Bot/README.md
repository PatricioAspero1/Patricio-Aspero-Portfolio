# Discord & Alert Integration

This project connects **Mnemosyne**, my local AI and automation system, with
Discord.

The Discord bot provides a lightweight interface for interacting with my local
Ollama model and selected homelab automation features without requiring direct
command-line access to Mnemosyne.

## Current Functionality

The current bot can:

- Accept messages from an explicitly approved Discord user
- Send prompts to a locally hosted Ollama model
- Return model responses through Discord
- Split long responses into Discord-safe message sizes
- Query selected weather information through a public API
- Provide a foundation for future infrastructure commands such as health and
  log summaries

## Architecture

```text
Discord
   |
   v
Python Bot
   |
   +----> Command Handling
   |
   +----> Public APIs
   |
   v
Ollama
   |
   v
Local LLM
   |
   v
Discord Response
```

## Security

The public version of this project is sanitized.

The Discord bot token, approved user ID, production endpoints, and other
environment-specific values have been removed from the source and replaced
with environment variables or placeholder values.

The production bot is also restricted so that only an explicitly configured
Discord user can interact with it.

[Read the Public Repository Sanitization Notice ->](../SANITIZATION.md)

## Technologies

- Python
- discord.py
- aiohttp
- Discord API
- Ollama
- Local LLMs
- REST APIs
- Linux
- systemd

## What I'm Learning

- Asynchronous Python
- API integration
- Discord bot development
- Environment-based secret management
- Error handling
- Local AI integration
- Restricting automation interfaces
- Running Python applications as Linux services

## Ongoing Development

Future goals include:

- Adding a `!health` command for summarized infrastructure status
- Adding read-only log queries
- Connecting the bot to Mnemosyne's existing health-check pipeline
- Improving permission controls
- Adding structured command handling
- Integrating alert notifications from the monitoring environment
- Keeping higher-impact administrative actions behind explicit approval

---

[<- Back to Scripts & Automation](../README.md)
