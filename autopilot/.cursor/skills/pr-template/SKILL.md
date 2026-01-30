---
name: pr-template
description: Use when opening a PR — title format "Feat/Fix - TSK-XXX – summary", body with JIRA link, changes, impacted models, dbt results. PT-BR for summary text.
---

# PR template

Use this skill when creating a Pull Request for an Autopilot task.

**The PR template is defined in the dbt project repo.** Look in the workspace for the project’s template (e.g. `.github/PULL_REQUEST_TEMPLATE.md`, `docs/pr-template.md`). Use it for the PR body when present; otherwise use the fallback below.

## When to use

- During /pr or when user says "open PR", "create PR".

## Title format

```
Feat - TSK-123 – <short summary in PT-BR>
Fix - TSK-123 – <short summary in PT-BR>
```

Example: `Feat - TSK-123 – Adiciona novos campos de fatura na obt de pagamentos`

## Body (fallback if no project template found)

Include:

- **JIRA:** Link to task (e.g. TSK-123).
- **Summary:** What changed (bullets).
- **Impacted models:** List of dbt models touched.
- **dbt results:** Link or summary of `dbt build` / tests.
- **Confidence level:** (optional).
- **Rollback notes:** If relevant.

## Rules (from @docs)

- One task per PR; no mixed concerns.
- Autopilot **never merges**; human approval required.
- Use gh CLI or GitHub API/MCP to create PR; assign reviewers if configured.
