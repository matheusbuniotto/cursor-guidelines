# Autopilot pr — Open Pull Request

**Spec:** @docs → `02_autopilot_commands.md` (§8), `00_project_overview.md` (§4.7–4.8), `03_failures_git_state.md` (§4).

Create the PR using gh CLI or GitHub API/MCP. **Autopilot never merges.** Human approval required.

## Steps

1. **Preconditions**  
   Review stage must be passed. If not, tell user to run `/review` first.

2. **PR title**  
   Format: `Feat - TSK-123 – <short summary>` or `Fix - TSK-123 – <summary>`. Use PT-BR for the summary text (e.g. "Adiciona novos campos de fatura na obt de pagamentos").

3. **PR body (template)**  
   **PR template, SQL guidelines, and other guides live in the dbt project repo.** Look in the workspace for the project’s PR template (e.g. `.github/PULL_REQUEST_TEMPLATE.md`, `docs/pr-template.md`, or similar). If found, use it for the body; otherwise use this fallback:
   - Linked JIRA task (link to ticket)
   - Summary of changes
   - Impacted models (list)
   - dbt results (or link to run)
   - Confidence level (optional)
   - Rollback notes if relevant

4. **Create PR**  
   Use `gh pr create` (or equivalent) with title and body. Target release branch. Do **not** merge. Assign reviewers if configured; request approval explicitly.

5. **Update state**  
   Update `.autopilot/state.json`: stage "pr", pr_url (if available).

6. **Reply**  
   Share PR link. Remind: "Autopilot never merges. Human approval required before merge."
