#!/bin/bash
# ============================================================================
# ClaudeAdvancedPlugins Uninstaller
# Removes all installed Claude Code custom slash commands.
# ============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGINS_DIR="$SCRIPT_DIR/plugins"
CLAUDE_COMMANDS_DIR="$HOME/.claude/commands"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${CYAN}${BOLD}"
echo "  ╔══════════════════════════════════════════════════════╗"
echo "  ║       Claude Advanced Plugins Uninstaller            ║"
echo "  ╚══════════════════════════════════════════════════════╝"
echo -e "${NC}"

REMOVED=0

for dir in "$PLUGINS_DIR"/*/; do
    for cmd in "$dir/commands/"*.md; do
        filename=$(basename "$cmd")
        if [ -f "$CLAUDE_COMMANDS_DIR/$filename" ]; then
            rm "$CLAUDE_COMMANDS_DIR/$filename"
            echo -e "${RED}  [-] Removed: $filename${NC}"
            REMOVED=$((REMOVED + 1))
        fi
    done
done

echo ""
if [ $REMOVED -gt 0 ]; then
    echo -e "${GREEN}[+] Uninstalled $REMOVED command(s) successfully.${NC}"
else
    echo -e "${YELLOW}[*] No installed commands found to remove.${NC}"
fi
