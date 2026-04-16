# AI-Coding-Skills

A skills repository for AI coding agents. Each skill is a planning guide written as markdown, optimised for 3 platforms:

- **Claude Code** (`claude.md`) - includes YAML frontmatter with skill metadata and trigger commands
- **Codex** (`codex.md`) - clean markdown for AGENTS.md or inline instructions
- **Cursor** (`cursor.md`) - clean markdown for `.cursor/rules/` or project settings

All skills require [assistgraph](https://github.com/assistagent/assistgraph) to be installed. Each skill instructs the agent to run `assistgraph build && assistgraph audit` in the workspace root before planning.

## Skills

| Skill | Purpose |
|---|---|
| [new-feature-plan](skills/new-feature-plan/) | Plan a new feature from scratch with full structure, API design, and testing |
| [migration-plan](skills/migration-plan/) | Plan a feature migration from a reference workspace with parity tracking |
| [refactor-plan](skills/refactor-plan/) | Plan a refactor targeting clean code, consolidation, and maintainability |
| [bugfix-plan](skills/bugfix-plan/) | Plan a targeted bug fix with dependency tracing and regression testing |

## Structure

```
skills/
├── new-feature-plan/
│   ├── claude.md
│   ├── codex.md
│   └── cursor.md
├── migration-plan/
│   ├── claude.md
│   ├── codex.md
│   └── cursor.md
├── refactor-plan/
│   ├── claude.md
│   ├── codex.md
│   └── cursor.md
└── bugfix-plan/
    ├── claude.md
    ├── codex.md
    └── cursor.md
```

## Usage

### Claude Code

Copy `claude.md` into `~/.claude/skills/<skill-name>/SKILL.md` to register as a slash command.

### Codex

Reference `codex.md` content in your `AGENTS.md` or paste into Codex instructions.

### Cursor

Add `cursor.md` content to `.cursor/rules/` or reference in project settings.
