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

## Quick Install

Install all skills globally for every platform in one command:

```bash
npm run install:all
```

Or install for a specific platform:

```bash
npm run install:claude
npm run install:codex
npm run install:cursor
```

You can also run the install script directly:

```bash
./install.sh              # all platforms
./install.sh claude       # Claude Code only
./install.sh codex        # Codex only
./install.sh cursor       # Cursor only
```

---

## Platform Details

### Claude Code (CLI)

Installs to `~/.claude/skills/`. Each skill gets its own folder with a `SKILL.md` file.

Once installed, use the skills as slash commands:

```
/bugfix-plan        — plan targeted bug fixes with dependency tracing
/migration-plan     — plan feature migrations between workspaces
/new-feature-plan   — plan new features from scratch
/refactor-plan      — plan codebase refactors for maintainability
```

> **Note:** This installs skills for the **Claude Code CLI only** (local machine). The Claude.ai web app uses a separate system — see below.

---

### Claude.ai (web)

The Claude.ai web app (Customize → Skills) does **not** read from `~/.claude/skills/`. It loads skills from either:

1. A connected **GitHub repo**, scanning for `skills/<skill-name>/SKILL.md` at the repo root, or
2. **Personal skills** uploaded manually in the Customize panel.

Because this repo nests skills under `skills/.claude/...` (to keep platform builds separate), Claude.ai's GitHub scanner will not discover them automatically. Pick one of the options below.

**Option A — Upload manually (recommended, fastest)**

1. Open Claude.ai → **Customize** → **Skills**.
2. Click the **+** icon next to *Personal skills*.
3. For each skill, upload the corresponding `SKILL.md` from `skills/.claude/<skill-name>/SKILL.md` in this repo.
4. Each uploaded skill becomes available as a slash command in any Claude.ai conversation.

**Option B — Connect via GitHub (auto-sync)**

To make Claude.ai discover the skills from a connected repo, the files must live at `skills/<skill-name>/SKILL.md` at the **top level** (not under a `.claude` dotfolder, which the scanner skips).

Either fork this repo and flatten the layout, or create a new repo structured like:

```
your-skills-repo/
└── skills/
    ├── bugfix-plan/SKILL.md
    ├── migration-plan/SKILL.md
    ├── new-feature-plan/SKILL.md
    └── refactor-plan/SKILL.md
```

Then in Claude.ai → **Customize** → **Skills**, connect the repo via the GitHub icon at the top of the sidebar. Skills sync automatically on commit.

**Verifying it worked**

- The skill should appear under *Personal skills* in the Customize panel with a toggle enabled.
- In a new conversation, typing `/` should list the skill name.
- If a skill does not appear after a GitHub connect, confirm the path is `skills/<name>/SKILL.md` exactly — any nesting under a dotfolder will cause it to be skipped.

---

### Codex (OpenAI)

Installs to `~/.codex/skills/`. Each skill is a standalone markdown file.

You can also append all skills into a single `AGENTS.md` for per-project use:

```bash
cat skills/.codex/*/*.md >> AGENTS.md
```

Reference them in your prompt with the `$` prefix:

```
$bugfix-plan        — plan targeted bug fixes with dependency tracing
$migration-plan     — plan feature migrations between workspaces
$new-feature-plan   — plan new features from scratch
$refactor-plan      — plan codebase refactors for maintainability
```

---

### Cursor

Installs to `~/.cursor/rules/`. Each skill is a `.mdc` rule file.

For per-project use instead, copy into your project:

```bash
mkdir -p .cursor/rules
cp skills/.cursor/*/*.mdc .cursor/rules/
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
