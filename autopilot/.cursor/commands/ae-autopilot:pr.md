# Autopilot pr — Open Pull Request

**Spec:** @docs → `02_autopilot_commands.md` (§8), `00_project_overview.md` (§4.7–4.8), `03_failures_git_state.md` (§4).

Create the PR using gh CLI or GitHub API/MCP. **Autopilot never merges.** Human approval required.

**Config:** Read `.autopilot/config.json` if present for `pr.default_reviewers`, `pr.team_label`, and `jira.*` (pós-PR).

## Steps

1. **Preconditions**  
   Review stage must be passed. If not, tell user to run `/ae-autopilot:review` first.

2. **Load config**  
   If `.autopilot/config.json` exists, read `pr.default_reviewers`, `pr.team_label`, `jira.review_status`, `jira.comment_after_pr`. Use them below.

3. **PR title**  
   Format: `Feat - TSK-123 – <short summary>` or `Fix - TSK-123 – <summary>`. Use PT-BR for the summary text (e.g. "Adiciona novos campos de fatura na obt de pagamentos").

4. **PR body (template)**  
   **PR template, SQL guidelines, and other guides live in the dbt project repo.** Look in the workspace for the project's PR template (e.g. `.github/PULL_REQUEST_TEMPLATE.md`, `docs/pr-template.md`, or similar). If found, use it for the body; otherwise use this fallback:
   - Linked JIRA task (link to ticket)
   - Summary of changes
   - Impacted models (list)
   - dbt results (or link to run)
   - Confidence level (optional)
   - Rollback notes if relevant

5. **Create PR**  
   Use `gh pr create` (or equivalent) with title and body. Target release branch. Do **not** merge.
   - If config has `pr.default_reviewers`, assign those reviewers (e.g. `gh pr create --reviewer lead-analytics` or equivalent).
   - If config has `pr.team_label`, add that label to the PR (e.g. `gh pr edit --add-label "equipe-analytics"` or equivalent).
   Request approval explicitly.

6. **Update state**  
   Update `.autopilot/state.json`: stage "pr", pr_url (if available).

7. **JIRA: move to Review + comment (PT-BR)**  
   - If config has `jira.comment_after_pr: true`, or if config is missing, **ask the user (PT-BR):**  
     "Deseja que eu mova a tarefa JIRA para **[review_status]** e comente na tarefa o que foi feito + link do PR?"
   - If user says **sim**:
     - If JIRA API or MCP is available: move the task to the status named `jira.review_status` (e.g. "Review") and add a comment in PT-BR with: short summary of what was done + PR link. Example comment:
       ```
       PR aberto em revisão.
       Resumo: [breve resumo do que foi feito]
       PR: [url do PR]
       ```
     - If JIRA API/MCP is **not** available: tell the user to do it manually and give them the exact comment text (PT-BR) and the status name to set. Example:
       "Mova a tarefa para **Review** e adicione este comentário na tarefa JIRA:
       ---
       PR aberto em revisão.
       Resumo: [breve resumo do que foi feito]
       PR: [url do PR]
       ---"
   - If user says **não**, skip and go to reply.

8. **Reply**  
   Share PR link. Remind: "Autopilot never merges. Human approval required before merge." If you asked about JIRA and user said sim, confirm what was done (move + comment) or what they need to do manually.
