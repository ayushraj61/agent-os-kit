#!/usr/bin/env bash
# Add missing project files without replacing existing files or following target symlinks.
set -euo pipefail
if [ "$#" -gt 1 ]; then
    echo "Usage: bash install.sh [project-directory]" >&2
    exit 2
fi
TARGET_DIR="${1:-.}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/template"
if [ -L "$TARGET_DIR" ]; then
    echo "Refusing a symbolic-link target: $TARGET_DIR" >&2
    exit 1
fi
mkdir -p "$TARGET_DIR"
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"
# Preflight all destination paths before writing anything.
while IFS= read -r source; do
    relative="${source#"$TEMPLATE_DIR/"}"
    destination="$TARGET_DIR/$relative"
    if [ -L "$destination" ] || { [ -e "$destination" ] && [ -d "$source" ] && [ ! -d "$destination" ]; } || { [ -e "$destination" ] && [ -f "$source" ] && [ ! -f "$destination" ]; }; then
        echo "Conflicting path; no template files installed: $destination" >&2
        exit 1
    fi
done < <(find "$TEMPLATE_DIR" -mindepth 1 -print)
while IFS= read -r source; do
    relative="${source#"$TEMPLATE_DIR/"}"
    destination="$TARGET_DIR/$relative"
    if [ -d "$source" ]; then
        mkdir -p "$destination"
    elif [ -e "$destination" ]; then
        echo "Preserved: $relative"
    else
        cp -n "$source" "$destination"
        echo "Installed: $relative"
    fi
done < <(find "$TEMPLATE_DIR" -mindepth 1 -print)
echo "Review existing CLAUDE.md / AGENTS.md: if preserved, add a reference to .agent/WORKFLOW.md manually."
echo "Next: ask your agent to inspect the backend and initialize relevant .agent/ state from your requirements."
