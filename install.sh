#!/bin/bash
set -e

SKILL_DIR="$(cd "$(dirname "$0")" && pwd)"
CLI_DIR="${SKILL_DIR}/../kalshi-cli"

echo "🎰 Installing kalshi-agent skill..."

# Clone kalshi-cli if not already present
if [ ! -d "$CLI_DIR" ]; then
    echo "📦 Cloning kalshi-cli..."
    git clone https://github.com/JThomasDevs/kalshi-cli.git "$CLI_DIR"
else
    echo "📦 kalshi-cli already present, pulling latest..."
    git -C "$CLI_DIR" pull
fi

# Set up virtual environment and install dependencies
echo "📦 Setting up Python environment..."
if [ ! -d "$CLI_DIR/.venv" ]; then
    python3 -m venv "$CLI_DIR/.venv"
fi
"$CLI_DIR/.venv/bin/pip" install -r "$CLI_DIR/requirements.txt"

# Set up credentials directory
mkdir -p "$HOME/.kalshi"
if [ ! -f "$HOME/.kalshi/.env" ]; then
    cat > "$HOME/.kalshi/.env" << 'EOF'
# Kalshi API Configuration
# Get credentials at: https://kalshi.com/api
KALSHI_ACCESS_KEY=your_access_key_here
EOF
    echo "📄 Created ~/.kalshi/.env — edit it with your API key"
fi

if [ ! -f "$HOME/.kalshi/private_key.pem" ]; then
    echo "⚠️  Place your RSA private key at ~/.kalshi/private_key.pem"
fi

echo ""
echo "✅ kalshi-agent installed!"
echo ""
echo "📋 Quick Start:"
echo "  1. Edit ~/.kalshi/.env with your API key"
echo "  2. Place your RSA private key at ~/.kalshi/private_key.pem"
echo "  3. Add alias to ~/.bashrc:"
echo "     alias kalshi=\"$CLI_DIR/.venv/bin/python3 $CLI_DIR/cli.py\""
echo "  4. kalshi --help"
