#!/bin/bash
# ============================================================================
# ClaudeAdvancedPlugins Installer
# Installs Claude Code custom slash commands for advanced development,
# security, and productivity workflows.
# ============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGINS_DIR="$SCRIPT_DIR/plugins"
CLAUDE_COMMANDS_DIR="$HOME/.claude/commands"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

echo -e "${CYAN}${BOLD}"
echo "  ╔══════════════════════════════════════════════════════╗"
echo "  ║        Claude Advanced Plugins Installer             ║"
echo "  ║        Security · Backend · Frontend · Memory        ║"
echo "  ╚══════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if Claude Code is likely installed
if ! command -v claude &> /dev/null; then
    echo -e "${YELLOW}[!] Claude Code CLI not found in PATH.${NC}"
    echo -e "${YELLOW}    Plugins will still be installed but require Claude Code to use.${NC}"
    echo -e "${YELLOW}    Install Claude Code: npm install -g @anthropic-ai/claude-code${NC}"
    echo ""
fi

# Create commands directory if it doesn't exist
mkdir -p "$CLAUDE_COMMANDS_DIR"

# Track installation
INSTALLED=0
SKIPPED=0
TOTAL=0

echo -e "${BLUE}[*] Installing plugins to: ${CLAUDE_COMMANDS_DIR}${NC}"
echo ""

# Function to install a plugin
install_plugin() {
    local plugin_name="$1"
    local plugin_dir="$PLUGINS_DIR/$plugin_name/commands"

    if [ ! -d "$plugin_dir" ]; then
        echo -e "${RED}  [-] Plugin directory not found: $plugin_name${NC}"
        return
    fi

    local count=0
    for cmd_file in "$plugin_dir"/*.md; do
        if [ -f "$cmd_file" ]; then
            local filename=$(basename "$cmd_file")
            TOTAL=$((TOTAL + 1))

            if [ -f "$CLAUDE_COMMANDS_DIR/$filename" ]; then
                if [ "$FORCE" = "true" ]; then
                    cp "$cmd_file" "$CLAUDE_COMMANDS_DIR/$filename"
                    count=$((count + 1))
                    INSTALLED=$((INSTALLED + 1))
                else
                    SKIPPED=$((SKIPPED + 1))
                    echo -e "${YELLOW}    [~] Skipped (exists): $filename ${NC}"
                    continue
                fi
            else
                cp "$cmd_file" "$CLAUDE_COMMANDS_DIR/$filename"
                count=$((count + 1))
                INSTALLED=$((INSTALLED + 1))
            fi
        fi
    done

    if [ $count -gt 0 ]; then
        echo -e "${GREEN}  [+] $plugin_name${NC} — $count command(s) installed"
    fi
}

# Parse arguments
FORCE=false
SELECTED_PLUGINS=()

while [[ $# -gt 0 ]]; do
    case $1 in
        --force|-f)
            FORCE=true
            shift
            ;;
        --list|-l)
            echo -e "${BOLD}Available Plugins:${NC}"
            echo ""
            for dir in "$PLUGINS_DIR"/*/; do
                plugin=$(basename "$dir")
                cmd_count=$(ls -1 "$dir/commands/"*.md 2>/dev/null | wc -l)
                echo -e "  ${CYAN}$plugin${NC} ($cmd_count commands)"
                for cmd in "$dir/commands/"*.md; do
                    echo -e "    └─ /$(basename "$cmd" .md)"
                done
            done
            exit 0
            ;;
        --plugin|-p)
            SELECTED_PLUGINS+=("$2")
            shift 2
            ;;
        --help|-h)
            echo "Usage: ./install.sh [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --force, -f           Overwrite existing commands"
            echo "  --list, -l            List available plugins and commands"
            echo "  --plugin, -p NAME     Install specific plugin(s) only"
            echo "  --uninstall, -u       Remove all installed commands"
            echo "  --help, -h            Show this help message"
            echo ""
            echo "Examples:"
            echo "  ./install.sh                           # Install all plugins"
            echo "  ./install.sh -p red-team-ops           # Install only red-team-ops"
            echo "  ./install.sh -p pentest-toolkit -f     # Force reinstall pentest-toolkit"
            echo "  ./install.sh --list                    # List all available plugins"
            exit 0
            ;;
        --uninstall|-u)
            echo -e "${YELLOW}[*] Uninstalling all Claude Advanced Plugins...${NC}"
            for dir in "$PLUGINS_DIR"/*/; do
                for cmd in "$dir/commands/"*.md; do
                    filename=$(basename "$cmd")
                    if [ -f "$CLAUDE_COMMANDS_DIR/$filename" ]; then
                        rm "$CLAUDE_COMMANDS_DIR/$filename"
                        echo -e "${RED}  [-] Removed: $filename${NC}"
                    fi
                done
            done
            echo -e "${GREEN}[+] Uninstall complete.${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            echo "Use --help for usage information."
            exit 1
            ;;
    esac
done

# Install plugins
if [ ${#SELECTED_PLUGINS[@]} -gt 0 ]; then
    echo -e "${BLUE}[*] Installing selected plugins...${NC}"
    echo ""
    for plugin in "${SELECTED_PLUGINS[@]}"; do
        install_plugin "$plugin"
    done
else
    echo -e "${BLUE}[*] Installing all plugins...${NC}"
    echo ""
    for dir in "$PLUGINS_DIR"/*/; do
        plugin=$(basename "$dir")
        install_plugin "$plugin"
    done
fi

echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}${BOLD}  Installation Complete!${NC}"
echo -e "  ${GREEN}Installed: $INSTALLED${NC} | ${YELLOW}Skipped: $SKIPPED${NC} | Total: $TOTAL"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${BOLD}Usage:${NC} In Claude Code, type ${CYAN}/<command-name>${NC} to use a plugin."
echo -e "  Example: ${CYAN}/backend-architect design a REST API for user management${NC}"
echo ""
echo -e "${BOLD}Available commands:${NC}"
for dir in "$PLUGINS_DIR"/*/; do
    plugin=$(basename "$dir")
    for cmd in "$dir/commands/"*.md; do
        echo -e "  ${CYAN}/$(basename "$cmd" .md)${NC}"
    done
done
echo ""
