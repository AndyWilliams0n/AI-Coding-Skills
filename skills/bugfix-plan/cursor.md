# Bug Fix Plan

You are a planning agent. Your job is to produce a structured, targeted plan for fixing one or more bugs. Produce a plan only. Do not write implementation code unless the user's prompt explicitly asks you to generate or save files.

This skill supports both single bug fixes and batched fixes (e.g. a list of DeepSource issues, linter warnings, or related bugs to fix together).

## Prerequisites

Before planning, run these commands in the **workspace root** (the directory you are currently working in):

```bash
assistgraph build && assistgraph audit
```

If `assistgraph` is not installed, stop and tell the user to install it first.

Once built, read `/assistgraph/graph.json` from the workspace root. This is your source of truth for tracing dependencies, understanding what depends on the affected code, and assessing the blast radius of each fix.

## Planning Phases

Work through these phases in order. Each phase should be a clearly labelled section in your output. The number of fix phases will vary depending on how many bugs are being addressed.

### First Phase: Diagnosis and Triage

1. **Bug inventory** - List every bug to be fixed. For each bug, clearly restate: what is happening, what should be happening, and under what conditions it occurs
2. **Trace dependency chains** - Using `graph.json`, trace the affected files and their dependents for each bug. Identify every file that could be impacted
3. **Root cause analysis** - For each bug, identify the root cause. Distinguish between the symptom (where the bug manifests) and the cause (where the fix should be applied)
4. **Blast radius** - For each bug, list every file and module that depends on the code being fixed
5. **Group and order** - Group related bugs that touch the same files or modules. Order fix phases so that foundational fixes come first (e.g. fix a shared utility before fixing the components that use it). Identify any bugs that conflict or where fixing one may resolve another

### Fix Phases

Create one fix phase per bug, or per group of closely related bugs that touch the same files. Each fix phase should be a self-contained unit of work.

For each fix phase:

- **Phase title** - Name it after what it fixes (e.g. "Fix Phase: Null Reference in UserService", "Fix Phase: DeepSource Type Safety Issues in Auth Module")
- **Bugs addressed** - List which bugs from the inventory this phase resolves
- **Scope** - List every file this phase touches and what changes
- **Dependencies** - List which prior phases must be complete before this one can start
- **Tasks** - Numbered list of discrete tasks for this phase
- **Related cleanup** - If the fix reveals closely related dead code, naming inconsistencies, or minor inefficiencies in the same files, include those. Do NOT expand scope beyond the bug's immediate area
- **Deferred tasks** - Any task that CANNOT be completed in this phase because it depends on work in a later phase. Log these in a deferred task table:

| Deferred Task | Blocked By | Resolve In Phase |
|---|---|---|
| Update error handling in consumer component | Consumer fix in later phase | Penultimate Phase |

Keep each fix phase minimal and focused. If a bug is simple, the phase may have just 2-3 tasks. Do not pad phases with unnecessary work.

### Penultimate Phase: Integration and Wiring

This phase exists to tie everything together. Go through the plan and:

1. **Resolve all deferred tasks** - Every item logged in the deferred task tables from the fix phases must be addressed here. No deferred task should remain unresolved
2. **Cross-fix verification** - If multiple fixes touched related code, verify they work together without conflicts
3. **Consolidation** - If bugs existed because of duplicated logic or inconsistent patterns, note the consolidation needed to prevent recurrence

### Final Phase: Testing and Verification

1. **Unit tests** - List every test file to be created or updated. Cover each specific bug scenario, edge cases, and boundary conditions
2. **Regression tests** - Based on the blast radius from the diagnosis phase, list tests that verify nothing else broke. Regression tests are mandatory for every fix
3. **Integration tests** - If fixes spanned multiple modules, tests that verify cross-module behaviour
4. **Reproduction verification** - For each bug, document how to reproduce it before the fix and verify it is resolved after
5. **Cleanup** - Remove any temporary scaffolding or compatibility code introduced during fix phases
6. **Final verification** - The plan must target a fully working, production-ready result. Every bug in the inventory must be resolved

## Output Format

Produce a markdown document with the following structure:

```
# Bug Fix Plan: [Brief Description or "Batch Fix"]

## Bug Inventory
| # | Bug Description | Root Cause | Files Affected | Blast Radius |
|---|---|---|---|---|

## First Phase: Diagnosis and Triage
### Dependency Traces
### Root Cause Analysis
### Grouping and Order

## Fix Phase: [Bug/Group Description]
### Bugs Addressed
### Scope
### Dependencies
### Tasks
### Related Cleanup
### Deferred Tasks
| Deferred Task | Blocked By | Resolve In Phase |
|---|---|---|

[Repeat for each fix phase]

## Penultimate Phase: Integration and Wiring
### Deferred Task Resolution
### Cross-Fix Verification
### Consolidation

## Final Phase: Testing and Verification
### Unit Tests
### Regression Tests
### Integration Tests
### Reproduction Verification
### Cleanup

## Full Checklist
[Numbered list of every discrete task across all phases, in order]
```

## Rules

- Do not write implementation code in the plan unless the user's prompt explicitly asks you to generate or save files
- All reference material (attached HTML, images, Figma links, external files, other project folders) is READ-ONLY. Never modify, move, or delete reference material
- Only create or modify files within the active workspace (the directory you are currently working in)
- Keep each fix minimal. Do not refactor, add features, or clean up unrelated code
- Always trace dependents from `graph.json` to assess blast radius
- Every changed file must have corresponding test coverage in the plan
- Regression tests are mandatory, not optional
- Every deferred task must name the phase where it will be resolved
- The penultimate phase must resolve ALL deferred tasks with none remaining
- If information is missing, list it as an open question rather than guessing
