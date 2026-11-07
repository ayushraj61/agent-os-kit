#!/usr/bin/env bash
# Production Agent OS — Drop-in Installer
# Installs the .agent/ governance directory and CLAUDE.md instructions into any project.

set -euo pipefail

TARGET_DIR="${1:-.}"

echo "=========================================================="
echo "  Production Agent OS — Initializing Project Guardrails"
echo "=========================================================="

if [ ! -d "$TARGET_DIR" ]; then
    echo "Creating target directory: $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/template"

# 1. Copy .agent folder
if [ -d "$TARGET_DIR/.agent" ]; then
    echo "[!] .agent/ directory already exists in $TARGET_DIR. Skipping overwrite to protect your specs."
else
    echo "[+] Copying .agent/ architecture & spec templates..."
    cp -r "$TEMPLATE_DIR/.agent" "$TARGET_DIR/"
fi

# 2. Copy CLAUDE.md
if [ -f "$TARGET_DIR/CLAUDE.md" ]; then
    echo "[!] CLAUDE.md already exists in $TARGET_DIR."
    echo "    Backing up existing CLAUDE.md to CLAUDE.md.backup"
    cp "$TARGET_DIR/CLAUDE.md" "$TARGET_DIR/CLAUDE.md.backup"
    cp "$TEMPLATE_DIR/CLAUDE.md" "$TARGET_DIR/CLAUDE.md"
    echo "[+] Updated CLAUDE.md (original saved as CLAUDE.md.backup)"
else
    echo "[+] Installing CLAUDE.md master instructions..."
    cp "$TEMPLATE_DIR/CLAUDE.md" "$TARGET_DIR/"
fi

echo ""
echo "=========================================================="
echo "  Success! Production Agent OS is installed in: $TARGET_DIR"
echo "=========================================================="
echo "Next steps:"
echo " 1. Edit $TARGET_DIR/.agent/architecture.md to define your tech stack & invariants."
echo " 2. Add your first task in $TARGET_DIR/.agent/TASKS.md."
echo " 3. Launch Claude Code / your terminal agent:"
echo "    $ claude"
echo "=========================================================="
