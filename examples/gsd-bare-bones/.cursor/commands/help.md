# GSD-style command reference

Display this reference. Do not add project-specific analysis or git status.

## Commands

- **`/new-project`** — Initialize project: ask what to build, create `.planning/PROJECT.md`, optionally REQUIREMENTS.md and ROADMAP.md.
- **`/plan-phase N`** — Create atomic plans for phase N under `.planning/phases/NN-name/`.
- **`/execute-phase N`** — Execute all plans for phase N; one task per plan, commit per task.

## Workflow

1. `/new-project` → define vision and scope  
2. `/plan-phase 1` → create plans for phase 1  
3. `/execute-phase 1` → run plans, commit as you go  
4. Repeat for next phase.

## Files created

- `.planning/PROJECT.md` — vision, goals, constraints  
- `.planning/REQUIREMENTS.md` — optional; v1 requirements  
- `.planning/ROADMAP.md` — optional; phases  
- `.planning/phases/NN-name/NN-MM-PLAN.md` — per-phase, per-task plans  
