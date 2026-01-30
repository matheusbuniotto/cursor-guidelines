# Autopilot execute-plan — Execute the plan

**Spec:** @docs → `02_autopilot_commands.md` (§6), `00_project_overview.md` (§4.5), `03_failures_git_state.md` (Git + state).

The user may append `--phase=N` or `--all` for L3. Anything after the command name is the argument.

## Steps

1. **Load state and plan**  
   Read `.autopilot/state.json` and `.autopilot/classification.json`. If L2, read `plan.yml`. If L3, determine phase from args (`--phase=1`, `--phase=2`, or `--all`).

2. **Execute by level**  
   - **L0:** Apply changes directly; no structured plan. Ask user if new tests or docs are needed (per @docs 00 §4.5).
   - **L1:** Execute inline steps; scoped dbt build.
   - **L2:** Execute `plan.yml` steps sequentially.
   - **L3:** Execute current phase only (or all phases if `--all`). Between phases, **soft stop**: confirm with user before next phase.

3. **Work rules**  
   - **SQL guidelines and other guides live in the dbt project repo.** Follow the project’s SQL style guide and existing codebase patterns (e.g. `docs/sql-style.md` or project docs in the workspace); follow dbt best practices.
   - **Never** `git add .` — always stage explicit files, e.g. `git add models/silver/orders.sql models/silver/schema.yml`.
   - Atomic commits per logical change; message in PT-BR (e.g. "Feat - Adiciona campos X na obt Y" or "Fix - Ajusta teste de freshness").
   - After each commit, append to `.autopilot/state.json` under `commits` (sha, message, timestamp).

4. **Stops**  
   On ambiguity, dbt failure outside expected scope, or Git conflicts: **hard stop**. Persist state and report.

5. **Update state**  
   Update `.autopilot/state.json`: stage "execute-plan", completed_phases (if L3), summary.what_was_done.

6. **Reply**  
   Summarize what was done and next: `/ae-autopilot:review`.
