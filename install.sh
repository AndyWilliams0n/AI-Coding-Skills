#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$SCRIPT_DIR/skills"

CLAUDE_TARGET="$HOME/.claude/skills"
CODEX_TARGET="$HOME/.codex/skills"
CURSOR_TARGET="$HOME/.cursor/rules"

SKILLS=(bugfix-plan migration-plan new-feature-plan refactor-plan)

install_claude() {
  echo "Installing skills for Claude Code..."

  for skill in "${SKILLS[@]}"; do
    mkdir -p "$CLAUDE_TARGET/$skill"
    cp "$SKILLS_DIR/.claude/$skill/SKILL.md" "$CLAUDE_TARGET/$skill/SKILL.md"
  done

  echo "  Installed to $CLAUDE_TARGET"
  echo "  Usage: /bugfix-plan, /migration-plan, /new-feature-plan, /refactor-plan"
  echo ""
}

install_codex() {
  echo "Installing skills for Codex..."

  mkdir -p "$CODEX_TARGET"

  for skill in "${SKILLS[@]}"; do
    cp "$SKILLS_DIR/.codex/$skill/$skill.md" "$CODEX_TARGET/$skill.md"
  done

  echo "  Installed to $CODEX_TARGET"
  echo "  Usage: \$bugfix-plan, \$migration-plan, \$new-feature-plan, \$refactor-plan"
  echo ""
}

install_cursor() {
  echo "Installing skills for Cursor..."

  mkdir -p "$CURSOR_TARGET"

  for skill in "${SKILLS[@]}"; do
    cp "$SKILLS_DIR/.cursor/$skill/$skill.mdc" "$CURSOR_TARGET/$skill.mdc"
  done

  echo "  Installed to $CURSOR_TARGET"
  echo "  Usage: /bugfix-plan, /migration-plan, /new-feature-plan, /refactor-plan"
  echo ""
}

install_all() {
  install_claude
  install_codex
  install_cursor
}

show_help() {
  echo "AI Coding Skills Installer"
  echo ""
  echo "Usage: ./install.sh [target]"
  echo ""
  echo "Targets:"
  echo "  all       Install skills for all platforms (default)"
  echo "  claude    Install skills for Claude Code (~/.claude/skills/)"
  echo "  codex     Install skills for Codex (~/.codex/skills/)"
  echo "  cursor    Install skills for Cursor (~/.cursor/rules/)"
  echo "  help      Show this help message"
  echo ""
}

case "${1:-all}" in
  all)     install_all ;;
  claude)  install_claude ;;
  codex)   install_codex ;;
  cursor)  install_cursor ;;
  help)    show_help ;;
  *)
    echo "Unknown target: $1"
    show_help
    exit 1
    ;;
esac

echo "Done."
