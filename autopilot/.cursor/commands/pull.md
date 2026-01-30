# Autopilot pull — Initialize work from a JIRA task

**Spec:** @docs → `02_autopilot_commands.md` (§4), `00_project_overview.md` (§4.1–4.3), `03_failures_git_state.md` (Git rules).

The user may provide a task ID (e.g. TSK-123) after the command: `/pull TSK-123`. If no ID, use AskUserQuestion to get the JIRA task ID or confirm they want to work without one (then still need branch name).

## Steps

1. **Resolve task ID**  
   From the message get the task ID (e.g. TSK-123). If missing, ask: "What is the JIRA task ID? (e.g. TSK-123)"

2. **Fetch JIRA task**  
   Fetch task metadata (description, acceptance criteria, labels, priority). If JIRA is not available, ask the user to paste summary and acceptance criteria. Write `.autopilot/task.json` with task_id, title, description, acceptance_criteria, labels.

3. **Sync release branch**  
   Identify release branch (e.g. `release/main` or `main`). Run `git fetch` and ensure local release branch is up to date. If outdated, stop and tell user to sync first.

4. **Create task branch**  
   Branch name **must** equal task ID:
   ```bash
   git switch -c TSK-123
   ```
   If branch already exists with uncommitted changes, **stop** and report (hard stop per @docs).

5. **Persist state**  
   Ensure `.autopilot/` exists. Create or update `.autopilot/state.json` with task_id, branch, stage: "pull", timestamps.

6. **Reply**  
   Summarize: task loaded, branch created. Next: run `/plan`.

## Git rules (non-negotiable)

- Never `git add .` or `git add -A`.
- One JIRA task → one branch; branch name = task ID.
