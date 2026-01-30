# Autopilot setup — Configuração de contexto (onboarding)

Cria ou atualiza `.autopilot/config.json` com dados do usuário, revisores, label do time e JIRA. Rode durante o onboarding ou quando mudar algo.

**Spec:** Config usado por `/pull` (git user), `/pr` (reviewers, label, JIRA pós-PR). Ver `autopilot/config.example.json` para o schema.

## Steps

1. **Check existing config**  
   If `.autopilot/config.json` exists, read it and show current values. Ask: "Atualizar config? (sim / não — só mostrar)".

2. **Auto-fill user.name and user.email (before asking)**  
   Try to get name and email so the user can confirm instead of typing.

   **2a. From GitHub (gh CLI)**  
   Run `gh api user` (requires `gh auth login`). From the JSON: use the `name` field for user.name (if present). The `email` field is often null in the public profile; if null, run `gh api user/emails` — if the response is 200, pick the entry with `"primary": true` and use its `email`; if 404/403 or no primary, skip email from gh. Commands: `gh api user`, `gh api user/emails`.

   **2b. From git config**  
   Run `git config user.name` and `git config user.email` (repo-local first, then global if unset). Use as fallback for name/email if gh didn't provide them. Commands: `git config user.name`, `git config user.email`.

   **2c. From GitHub MCP**  
   If the agent has GitHub MCP (or similar) and can get the authenticated user's profile (name, email), use that to pre-fill. Prefer MCP if it returns email and gh/git did not.

   **2d. Pre-fill and confirm**  
   If any value was found for name or email, show the user in PT-BR: "Encontrei: Nome: [X], Email: [Y]. Usar esses? (sim / editar)"  
   - If **sim** — use the found values for user.name and user.email.  
   - If **editar** or user wants to change — ask: "Nome para commits:" and "Email para commits:" and use the answers.  
   If nothing was found, ask: "Nome para commits (git user.name):" and "Email para commits (git user.email):" and use the answers.

3. **Collect remaining values (use AskUserQuestion or inline; PT-BR)**  
   Ask the user for the following. Use defaults from existing config when present.

   - **pr.default_reviewers** — Lista de usernames do GitHub para revisar PRs (e.g. `["lead-analytics"]`).  
     Ask: "Revisor(es) padrão do PR (usernames GitHub, separados por vírgula):"
   - **pr.team_label** — Label do time no PR (e.g. "equipe-analytics").  
     Ask: "Label do time para o PR (ex.: equipe-analytics):"
   - **jira.project_key** — Chave do projeto JIRA (e.g. "TSK").  
     Ask: "Chave do projeto JIRA (ex.: TSK):"
   - **jira.board_id** — ID do board JIRA, se relevante (opcional).  
     Ask: "ID do board JIRA (opcional):"
   - **jira.review_status** — Nome do status para "Em revisão" (e.g. "Review").  
     Ask: "Nome do status JIRA para 'Em revisão' (ex.: Review):"
   - **jira.comment_after_pr** — Se após abrir o PR devemos perguntar se move a tarefa para Review e comenta.  
     Ask: "Após abrir PR, perguntar se move a tarefa para Review e comenta no JIRA? (sim/não)" → true/false.

4. **Write config**  
   Ensure `.autopilot/` exists. Write `.autopilot/config.json` with the collected values. Use this schema:

   ```json
   {
     "user": { "name": "...", "email": "..." },
     "pr": { "default_reviewers": ["..."], "team_label": "..." },
     "jira": {
       "project_key": "...",
       "board_id": "...",
       "review_status": "...",
       "comment_after_pr": true
     }
   }
   ```

   Omit optional fields if empty. Keep existing fields not asked (e.g. other keys) if updating.

5. **Remind .gitignore**  
   Tell the user: "Se não quiser versionar dados pessoais, adicione `.autopilot/config.json` ao `.gitignore` (opcional)."

6. **Reply**  
   Confirm what was written. Next: run `/pull TSK-XXX` or `/launch TSK-XXX`.
