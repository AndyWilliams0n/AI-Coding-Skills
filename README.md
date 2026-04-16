# AI-Coding-Skills

A skills repository for AI coding agents. Each skill is a structured planning guide that walks the agent through a full dev cycle - from setup and scaffolding through implementation phases to final polish and testing.

All skills use [assistgraph](https://github.com/assistagent/assistgraph) for dependency awareness. Each skill instructs the agent to run `assistgraph build && assistgraph audit` in the workspace root before planning.

## Skills

| Skill | Purpose |
|---|---|
| **new-feature-plan** | Plan a new feature from scratch with full structure, API design, and testing |
| **migration-plan** | Plan a feature migration from a reference workspace with parity tracking |
| **refactor-plan** | Plan a codebase refactor targeting clean code, consolidation, and maintainability |
| **bugfix-plan** | Plan targeted bug fixes (single or batch) with dependency tracing and regression testing |

## Structure

Skills are organised by platform, ready to copy directly into your tool's config directory:

```
skills/
├── .claude/
│   ├── bugfix-plan/SKILL.md
│   ├── migration-plan/SKILL.md
│   ├── new-feature-plan/SKILL.md
│   └── refactor-plan/SKILL.md
├── .codex/
│   ├── bugfix-plan/bugfix-plan.md
│   ├── migration-plan/migration-plan.md
│   ├── new-feature-plan/new-feature-plan.md
│   └── refactor-plan/refactor-plan.md
└── .cursor/
    ├── bugfix-plan/bugfix-plan.mdc
    ├── migration-plan/migration-plan.mdc
    ├── new-feature-plan/new-feature-plan.mdc
    └── refactor-plan/refactor-plan.mdc
```

---

## Installation

### Claude Code

Copy the entire `.claude` skills folder into your home directory:

```bash
cp -r skills/.claude/* ~/.claude/skills/
```

That's it. All 4 skills are now available globally as slash commands:

```
/bugfix-plan        — plan targeted bug fixes with dependency tracing
/migration-plan     — plan feature migrations between workspaces
/new-feature-plan   — plan new features from scratch
/refactor-plan      — plan codebase refactors for maintainability
```

---

### Codex (OpenAI)

Copy the `.codex` folder into your project root:

```bash
cp -r skills/.codex .
```

Or append all skills into a single `AGENTS.md`:

```bash
cat skills/.codex/*/*.md >> AGENTS.md
```

Then reference them in your prompt with the `$` prefix:

```
$bugfix-plan        — plan targeted bug fixes with dependency tracing
$migration-plan     — plan feature migrations between workspaces
$new-feature-plan   — plan new features from scratch
$refactor-plan      — plan codebase refactors for maintainability
```

---

### Cursor

**Per-project setup** - copy into your project:

```bash
cp skills/.cursor/*/*.mdc .cursor/rules/
```

**Global setup** - copy into your home directory:

```bash
mkdir -p ~/.cursor/rules
cp skills/.cursor/*/*.mdc ~/.cursor/rules/
```

Once installed, use the skills in Cursor's chat or agent mode with the `/` prefix followed by the rule name:

```
/bugfix-plan        — plan targeted bug fixes with dependency tracing
/migration-plan     — plan feature migrations between workspaces
/new-feature-plan   — plan new features from scratch
/refactor-plan      — plan codebase refactors for maintainability
```

---

## Prerequisites

All skills require the `assistgraph` CLI to be installed in your environment. Each skill will prompt you to install it if it is not found.

```bash
npm install -g assistgraph
```
