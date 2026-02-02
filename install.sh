#!/bin/bash

# EpicCheck Installation Script
# This script installs EpicCheck on your system

set -e

INSTALL_DIR="${HOME}/.local/bin"
EPICCHECK_URL="https://raw.githubusercontent.com/YOUR_REPO/epiccheck/main/epiccheck"

echo "🍌 EpicCheck Installer"
echo "====================="
echo ""

# Create installation directory if it doesn't exist
if [ ! -d "$INSTALL_DIR" ]; then
    echo "📁 Creating directory $INSTALL_DIR..."
    mkdir -p "$INSTALL_DIR"
fi

# Download epiccheck
echo "⬇️  Downloading EpicCheck..."
if command -v curl &> /dev/null; then
    curl -fsSL "$EPICCHECK_URL" -o "$INSTALL_DIR/epiccheck"
elif command -v wget &> /dev/null; then
    wget -q "$EPICCHECK_URL" -O "$INSTALL_DIR/epiccheck"
else
    echo "❌ Error: Neither curl nor wget is installed."
    echo "Please install one of them and try again."
    exit 1
fi

# Make it executable
echo "🔧 Making EpicCheck executable..."
chmod +x "$INSTALL_DIR/epiccheck"

# Check if directory is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "⚠️  Warning: $INSTALL_DIR is not in your PATH"
    echo ""
    echo "Add this line to your ~/.bashrc or ~/.zshrc:"
    echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo ""
    echo "Then run: source ~/.bashrc  (or ~/.zshrc)"
fi

# Test installation
if [ -x "$INSTALL_DIR/epiccheck" ]; then
    echo ""
    echo "✅ EpicCheck installed successfully!"
    echo ""
    echo "Usage:"
    echo "    epiccheck .                  # Check current directory"
    echo "    epiccheck src/               # Check src directory"
    echo "    epiccheck --help             # Show help"
    echo ""
else
    echo "❌ Installation failed"
    exit 1
fi
