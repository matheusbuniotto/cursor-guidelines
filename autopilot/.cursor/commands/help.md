# Autopilot — Command reference

Display this reference. Do not add project-specific analysis.

**Full spec:** @docs — read `00_project_overview.md`, `01_task_classification.md`, `02_autopilot_commands.md`, `03_failures_git_state.md` for behavior and guardrails.

## Commands

| Command | Responsibility |
|---------|----------------|
| `/pull TSK-123` | Pull JIRA task, sync release branch, create task branch `TSK-123` |
| `/plan` | Classify task (L0–L3), generate plan if needed (L2 → plan.yml, L3 → phases) |
| `/execute-plan` | Execute work; use `--phase=N` or `--all` for L3 |
| `/review` | Run dbt build/tests, SQL style, docs; block PR if failures |
| `/pr` | Open Pull Request (template); never merge |
| `/launch TSK-123` | Run full flow: pull → plan → execute-plan → review → pr |

## Workflow

**Default:** `/launch TSK-123` (one task → one branch → one PR)

**Step-by-step:** `/pull TSK-123` → `/plan` → `/execute-plan` → `/review` → `/pr`

## Artifacts

- `.autopilot/task.json` — after pull
- `.autopilot/classification.json` — after plan
- `.autopilot/state.json` — progress, commits, summary
- `plan.yml` — only for L2/L3

## Rules (from @docs)

- **Idioma:** Commits e PRs são sempre em **português brasileiro (PT-BR)** — mensagens de commit, título e descrição do PR.
- **Git:** Never `git add .`; always stage explicit paths. One task → one branch; branch name = task ID.
- **PR:** Primary artifact; Autopilot never merges; human approval required.
- **Stops:** On ambiguity, failure, or missing confirmation — stop and persist state.
