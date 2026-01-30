# Autopilot — Command reference

Display this reference. Do not add project-specific analysis.

**Full spec:** @docs — read `00_project_overview.md`, `01_task_classification.md`, `02_autopilot_commands.md`, `03_failures_git_state.md` for behavior and guardrails.

## Commands

| Command | Responsibility |
|---------|----------------|
| `/ae-autopilot:setup` | Onboarding: cria/atualiza `.autopilot/config.json` (nome, email, revisor, label, JIRA) |
| `/ae-autopilot:pull TSK-123` | Pull JIRA task, sync release branch, create task branch `TSK-123` |
| `/ae-autopilot:plan` | Classify task (L0–L3), generate plan if needed (L2 → plan.yml, L3 → phases) |
| `/ae-autopilot:execute-plan` | Execute work; use `--phase=N` or `--all` for L3 |
| `/ae-autopilot:review` | Run dbt build/tests, SQL style, docs; block PR if failures |
| `/ae-autopilot:pr` | Open Pull Request (template); never merge |
| `/ae-autopilot:launch TSK-123` | Run full flow: pull → plan → execute-plan → review → pr |
| `/ae-autopilot:help` | Show this reference |

## Workflow

**Default:** `/ae-autopilot:launch TSK-123` (one task → one branch → one PR)

**Step-by-step:** `/ae-autopilot:pull TSK-123` → `/ae-autopilot:plan` → `/ae-autopilot:execute-plan` → `/ae-autopilot:review` → `/ae-autopilot:pr`

## Artifacts

- `.autopilot/config.json` — user, reviewers, label, JIRA (from `/ae-autopilot:setup`; optional, often gitignored)
- `.autopilot/task.json` — after pull
- `.autopilot/classification.json` — after plan
- `.autopilot/state.json` — progress, commits, summary
- `plan.yml` — only for L2/L3

## Rules (from @docs)

- **Idioma:** Commits e PRs são sempre em **português brasileiro (PT-BR)** — mensagens de commit, título e descrição do PR.
- **Git:** Never `git add .`; always stage explicit paths. One task → one branch; branch name = task ID.
- **PR:** Primary artifact; Autopilot never merges; human approval required.
- **Stops:** On ambiguity, failure, or missing confirmation — stop and persist state.
