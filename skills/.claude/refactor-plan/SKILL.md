---
skill: refactor-plan
platform: claude-code
trigger: /refactor-plan
description: Plan a codebase refactor using assistgraph for dependency awareness, targeting clean code, consolidation, and maintainability.
---

# Refactor Plan

You are a planning agent. Your job is to produce a structured, thorough refactoring plan. Produce a plan only. Do not write implementation code unless the user's prompt explicitly asks you to generate or save files.

## Prerequisites

Before planning, run these commands in the **workspace root** (the directory you are currently working in):

```bash
assistgraph build && assistgraph audit
```

If `assistgraph` is not installed, stop and tell the user to install it first.

Once built, read `/assistgraph/graph.json` from the workspace root. This is your source of truth for the existing codebase structure, dependencies, circular imports, orphan files, and module boundaries.

Pay special attention to the audit results. These highlight existing problems (circular dependencies, orphan files, oversized modules) that the refactor should address.

## Planning Phases

Work through these phases in order. Each phase should be a clearly labelled section in your output. The number of implementation phases will vary depending on the complexity of the refactor.

### First Phase: Setup and Scaffolding

1. **Analyse the dependency graph** - Identify problem areas: circular dependencies, tightly coupled modules, orphan files, oversized components, and duplicated patterns
2. **Dependency cleanup** - List packages to remove, upgrade, or consolidate. Identify duplicate or overlapping dependencies. Include install/uninstall commands
3. **Files and folder structure** - Map out structural changes: files to move, rename, split, or merge. Show before and after paths. Create any new folders needed
4. **Shared vs feature components** - Identify components that are currently feature-scoped but should be promoted to shared, and any shared components that are only used once and should be demoted

### Next Phase: Layouts and Components

5. **Target component changes** - For each component being refactored, define what changes and why. Focus on the interface (props, inputs/outputs) not internal implementation
6. **API design refactoring** - If the refactor touches API layers, define endpoint changes, deprecations, and migration paths
7. **Backend to frontend integration changes** - If refactoring crosses the stack, map how data flow changes between backend and frontend
8. **Attached resources** - If the user has provided HTML mockups, images, or Figma links, use these as the definitive guide for any layout or styling changes

### Implementation Phases

Break the remaining work into multiple discrete phases. Each phase should be a self-contained unit of work that can be completed and verified independently. Split by module, feature area, or logical boundary - whichever produces the clearest separation.

For each implementation phase:

- **Phase title** - Name it after what it delivers (e.g. "Implementation Phase: Auth Service Consolidation", "Implementation Phase: Dashboard Component Split")
- **Scope** - List every file this phase touches, with before/after paths for moves and renames
- **Dependencies** - List which prior phases must be complete before this one can start
- **Tasks** - Numbered list of discrete tasks for this phase
- **Clean code gains** - Specific improvements in this phase: deduplication, naming, dead code removal, simplification
- **Deferred tasks** - Any task that CANNOT be completed in this phase because it depends on work in a later phase. Log these in a deferred task table:

| Deferred Task | Blocked By | Resolve In Phase |
|---|---|---|
| Update import paths in dashboard module | Dashboard module refactored in later phase | Penultimate Phase |

Keep implementation phases granular. Each phase should be completable without leaving broken code. Order phases so that foundational changes (shared utilities, core services) come before dependent changes (feature modules that import them).

### Penultimate Phase: Integration and Wiring

This phase exists to tie everything together. Go through the plan and:

1. **Resolve all deferred tasks** - Every item logged in the deferred task tables from the implementation phases must be addressed here. No deferred task should remain unresolved
2. **Cross-module wiring** - Update all import paths, re-exports, and barrel files affected by moves and renames across phases
3. **Consolidation verification** - Verify that duplicated code identified in earlier phases has been properly consolidated
4. **Error handling consistency** - Ensure error handling patterns are consistent across all refactored modules

### Final Phase: Polish and Testing

1. **Clean code audit** - Final review of all changes for naming consistency, dead code, unnecessary complexity
2. **Consolidation and efficiency** - Verify all merge opportunities have been captured: similar utilities, reducible bundle size, simplified dependency tree
3. **Maintenance gains** - Document how the refactor improves long-term maintainability: clearer module boundaries, better separation of concerns, easier testing
4. **Unit tests** - List every test file to be created or updated. Tests are especially important during refactoring to prevent regressions. Cover all changed components, services, and utilities
5. **Integration tests** - Tests that verify cross-module wiring works correctly after structural changes
6. **Documentation** - Document the refactored structure: what changed, where things moved, and why
7. **Cleanup** - Remove any temporary scaffolding, unused imports, or compatibility shims introduced during implementation phases
8. **Final verification** - The plan must target a fully working, production-ready result. No broken imports, no missing references, no partial refactors

## Output Format

Produce a markdown document with the following structure:

```
# Refactor Plan: [Scope Description]

## Summary
[2-3 sentence overview of what is being refactored and why]

## Audit Findings
[Key issues from assistgraph audit]

## First Phase: Setup and Scaffolding
### Problem Areas
### Dependency Cleanup
### File and Folder Changes (Before/After)
### Shared vs Feature Components

## Next Phase: Layouts and Components
### Component Changes
### API Refactoring
### Integration Changes
### Resource References

## Implementation Phase: [Module/Area Name]
### Scope (Before/After)
### Dependencies
### Tasks
### Clean Code Gains
### Deferred Tasks
| Deferred Task | Blocked By | Resolve In Phase |
|---|---|---|

[Repeat for each implementation phase]

## Penultimate Phase: Integration and Wiring
### Deferred Task Resolution
### Cross-Module Wiring
### Consolidation Verification
### Error Handling Consistency

## Final Phase: Polish and Testing
### Clean Code Audit
### Consolidation and Efficiency
### Maintenance Gains
### Unit Tests
### Integration Tests
### Documentation
### Cleanup

## Risk Assessment
[What could break, and how to mitigate]

## Full Checklist
[Numbered list of every discrete task across all phases, in order]
```

## Rules

- Do not write implementation code in the plan unless the user's prompt explicitly asks you to generate or save files
- All reference material (attached HTML, images, Figma links, external files, other project folders) is READ-ONLY. Never modify, move, or delete reference material
- Only create or modify files within the active workspace (the directory you are currently working in)
- Always reference existing patterns from `graph.json`
- Show before/after for every structural change
- Order the checklist so that no task breaks the build when completed in sequence
- Every deferred task must name the phase where it will be resolved
- The penultimate phase must resolve ALL deferred tasks with none remaining
- Flag any circular dependency risks introduced by the refactor
- If information is missing, list it as an open question rather than guessing
