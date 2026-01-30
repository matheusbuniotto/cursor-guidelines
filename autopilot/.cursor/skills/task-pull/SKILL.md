---
name: task-pull
description: Use when the user wants to start work from a JIRA task — fetch task, sync release branch, create task branch (TSK-XXX).
---

# Task pull

Use this skill when the user provides a JIRA task ID (e.g. TSK-123) or says "pull task", "start task", "init from JIRA".

## When to use

- User says "pull TSK-123", "start TSK-123", "init from JIRA TSK-123".
- User wants to begin work on a ticket and need branch + context.

## Steps

1. Resolve task ID from message or ask with AskUserQuestion.
2. Fetch JIRA task metadata (description, acceptance criteria, labels). If JIRA unavailable, ask user to paste summary.
3. Write `.autopilot/task.json` with task_id, title, description, acceptance_criteria, labels.
4. Sync release branch (e.g. `release/main` or `main`): `git fetch`; ensure up to date.
5. Create task branch: `git switch -c TSK-XXX` (branch name = task ID).
6. Create or update `.autopilot/state.json`: task_id, branch, stage "pull".

## Rules (from @docs)

- One JIRA task → one branch; branch name must equal task ID.
- If branch exists with uncommitted changes → stop and report.
