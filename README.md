# kalshi-agent

OpenClaw skill for trading prediction markets on [Kalshi](https://kalshi.com).

This skill wraps [**kalshi-cli**](https://github.com/JThomasDevs/kalshi-cli), a standalone CLI for browsing, searching, and trading on Kalshi from your terminal.

## Dependencies

* [kalshi-cli](https://github.com/JThomasDevs/kalshi-cli) — the core CLI tool (required)
* Python 3.10+
* Kalshi API credentials ([get them here](https://kalshi.com/api))

## Installation

### 1. Install kalshi-cli
```bash
npm install -g kalshi-cli
```

### 2. Configure API credentials
```bash
mkdir -p ~/.kalshi
# Place your RSA private key at ~/.kalshi/private_key.pem

# Set your access key
echo 'KALSHI_ACCESS_KEY=your_access_key_id' > ~/.kalshi/.env
```

Or run `kalshi setup-shell` to export the access key to your shell config automatically.

## Quick Start
```bash
kalshi search soccer          # find soccer markets
kalshi series -e              # browse series sorted by expiry
kalshi detail KXSB-26         # market details
kalshi buy KXSB-26 10 68      # buy 10 YES contracts at 68¢
kalshi balance                # check balance
```

See [kalshi-cli](https://github.com/JThomasDevs/kalshi-cli) for full command reference and documentation.

## Running with OpenClaw

### Installing the skill

Clone the skill into your OpenClaw managed skills directory:
```bash
git clone https://github.com/JThomasDevs/kalshi-agent ~/.openclaw/skills/kalshi-agent
```

Then restart the gateway:
```bash
openclaw gateway restart
```

Verify it loaded:
```bash
openclaw skills list --eligible
```

### Tools profile requirement

The skill requires exec/bash tool access to run CLI commands. If your OpenClaw `tools.profile` is set to `messaging`, the agent will load the skill but won't be able to execute any commands. Set your profile to `coding` or `full` in `~/.openclaw/openclaw.json`:
```json
"tools": {
  "profile": "coding"
}
```

### API key with systemd

If OpenClaw runs as a systemd service (the default when installed via npm), `~/.bashrc` exports are not visible to the gateway process. Running `kalshi setup-shell` adds the key to `~/.bashrc`, but this won't work for the service. Instead, add the key to the service environment:
```bash
systemctl --user edit openclaw-gateway.service
```

Add:
```
[Service]
Environment="KALSHI_ACCESS_KEY=your_access_key_id"
```

Then:
```bash
systemctl --user daemon-reload
openclaw gateway restart
```

## Skill Metadata

This skill is designed for [OpenClaw](https://github.com/openclaw) agents. See `SKILL.md` for agent integration details.

## License

MIT
