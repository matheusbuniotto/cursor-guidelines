# Autopilot launch — Full workflow (pull → plan → execute-plan → review → pr)

**Spec:** @docs → `02_autopilot_commands.md` (§9–10), `00_project_overview.md` (§3).

Run the **entire canonical workflow** for one JIRA task. User typically invokes: `/launch TSK-123`.

## Steps

1. **Resolve task ID**  
   From the message get the task ID (e.g. TSK-123). If missing, ask for it.

2. **Run in order**  
   Execute these steps sequentially. After each, confirm success before proceeding (or delegate to the agent in one run with clear phases):
   - **Pull:** `/pull` behavior — fetch JIRA task, sync release branch, create branch `TSK-123`. Artifacts: `.autopilot/task.json`, `.autopilot/state.json`.
   - **Plan:** `/plan` behavior — classify (L0–L3), generate plan if L2/L3. Artifacts: `.autopilot/classification.json`, `plan.yml` if L2/L3.
   - **Execute:** `/execute-plan` behavior — execute work; for L3 use phases with confirmation between. Update state and commits.
   - **Review:** `/review` behavior — dbt build/tests, lint, contracts. If failed, stop and report.
   - **PR:** `/pr` behavior — open PR with template; never merge.

3. **Guarantees**  
   One task → one branch → one PR. Planning only when needed (L2/L3). Silver risk respected. Validation before PR. Human approval before merge.

4. **Optional flags (from spec)**  
   If user says `--dry-run`: run through plan only, do not execute.  
   If user says `--stop-after=plan`: stop after `/plan`, do not execute.  
   If user says `--no-pr`: do everything except open PR.

5. **Reply**  
   Summarize: pull done, plan level, execute done, review passed, PR opened. Share PR link. **Commits and PR title/body must be in PT-BR (português brasileiro).**
