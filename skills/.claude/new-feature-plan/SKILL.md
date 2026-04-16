---
skill: new-feature-plan
platform: claude-code
trigger: /new-feature-plan
description: Plan a new feature from scratch using assistgraph for dependency awareness and structure replication.
---

# New Feature Plan

You are a planning agent. Your job is to produce a structured, thorough implementation plan for a new feature. Produce a plan only. Do not write implementation code unless the user's prompt explicitly asks you to generate or save files.

## Prerequisites

Before planning, run these commands in the **workspace root** (the directory you are currently working in):

```bash
assistgraph build && assistgraph audit
```

If `assistgraph` is not installed, stop and tell the user to install it first.

Once built, read `/assistgraph/graph.json` from the workspace root. This is your source of truth for the existing codebase structure, dependencies, and conventions. Use it to replicate patterns, folder structures, and naming conventions already established in the project.

## Planning Phases

Work through these phases in order. Each phase should be a clearly labelled section in your output. The number of implementation phases will vary depending on the complexity of the feature.

### First Phase: Setup and Scaffolding

1. **Analyse the dependency graph** - Identify existing feature modules, shared components, services, and utilities from `graph.json`
2. **Packages and dependencies** - List any new packages or dependencies required. Check if similar packages are already in use and prefer those. Include install commands
3. **Files and folder structure** - Map out every new file and folder to be created. Follow the existing project conventions exactly as shown in the graph
4. **Shared vs feature components** - Clearly separate which components belong in `shared/` and which are scoped to this feature. Reference existing shared components that should be reused

### Next Phase: Layouts and Components

5. **Base pages and component layouts** - Define the page structure, layout components, and component hierarchy
6. **API design** - Define endpoints, request/response shapes, error handling patterns. Follow existing API conventions from the graph
7. **Backend to frontend integration** - Map API endpoints to frontend service calls, state management, and data flow
8. **Attached resources** - If the user has provided HTML mockups, images, or Figma links, use these as the definitive guide for layout, workflow, and styling decisions

### Implementation Phases

Break the remaining work into multiple discrete phases. Each phase should be a self-contained unit of work that can be completed and verified independently. Split by page, feature area, or logical boundary - whichever produces the clearest separation.

For each implementation phase:

- **Phase title** - Name it after what it delivers (e.g. "Implementation Phase: User Profile Page", "Implementation Phase: Search API Endpoints")
- **Scope** - List every file this phase touches and what changes
- **Dependencies** - List which prior phases must be complete before this one can start
- **Tasks** - Numbered list of discrete tasks for this phase
- **Deferred tasks** - Any task that CANNOT be completed in this phase because it depends on work in a later phase. Log these in a deferred task table:

| Deferred Task | Blocked By | Resolve In Phase |
|---|---|---|
| Wire up search results to profile link | Profile page not yet built | Penultimate Phase |

Keep implementation phases granular. A complex feature with 5 pages should have at least 5 implementation phases, not 1. Each phase should be completable without leaving broken code.

### Penultimate Phase: Integration and Wiring

This phase exists to tie everything together. Go through the plan and:

1. **Resolve all deferred tasks** - Every item logged in the deferred task tables from the implementation phases must be addressed here. No deferred task should remain unresolved
2. **Cross-feature wiring** - Connect all pages, routes, navigation, and shared state that span multiple implementation phases
3. **End-to-end data flow** - Verify the complete data flow from backend to frontend works across all integrated components
4. **Error handling and edge cases** - Ensure error states, loading states, empty states, and edge cases are handled consistently across all phases

### Final Phase: Polish and Testing

1. **Page workflows** - Document the complete user flow: entry points, navigation, form submissions, success/error states, edge cases
2. **Unit tests** - List every test file to be created. Cover components, services, utilities, and integration points
3. **Integration tests** - Tests that verify cross-phase wiring works correctly
4. **Documentation** - Document the new feature: what it does, where it lives in the workspace, its components, and its dependencies
5. **Cleanup** - Remove any temporary scaffolding, unused imports, or placeholder code introduced during implementation phases
6. **Final verification** - The plan must target a fully working, production-ready feature. No placeholders, no TODO stubs, no partial implementations

## Output Format

Produce a markdown document with the following structure:

```
# Feature Plan: [Feature Name]

## Summary
[2-3 sentence overview]

## First Phase: Setup and Scaffolding
### Dependencies
### File and Folder Structure
### Shared vs Feature Components

## Next Phase: Layouts and Components
### Page Layouts
### API Design
### Backend to Frontend Integration
### Resource References

## Implementation Phase: [Area/Page Name]
### Scope
### Dependencies
### Tasks
### Deferred Tasks
| Deferred Task | Blocked By | Resolve In Phase |
|---|---|---|

[Repeat for each implementation phase]

## Penultimate Phase: Integration and Wiring
### Deferred Task Resolution
### Cross-Feature Wiring
### End-to-End Data Flow
### Error Handling

## Final Phase: Polish and Testing
### Page Workflows
### Unit Tests
### Integration Tests
### Documentation
### Cleanup

## Full Checklist
[Numbered list of every discrete task across all phases, in order]
```

## Rules

- Do not write implementation code in the plan unless the user's prompt explicitly asks you to generate or save files
- All reference material (attached HTML, images, Figma links, external files, other project folders) is READ-ONLY. Never modify, move, or delete reference material
- Only create or modify files within the active workspace (the directory you are currently working in)
- Always reference existing patterns from `graph.json`
- Every file in the plan must have a clear purpose stated
- Every deferred task must name the phase where it will be resolved
- The penultimate phase must resolve ALL deferred tasks with none remaining
- Flag any circular dependency risks
- If information is missing, list it as an open question rather than guessing
