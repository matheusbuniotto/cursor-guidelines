# Autopilot — Onboarding (5 min)

For **Analytics Engineers** joining a team that uses Autopilot with Cursor.

---

## 1. Install

Copy the **`.cursor/`** folder from the `autopilot/` directory into your **dbt project root**.

```
your-dbt-project/
├── .cursor/          ← paste here (commands, agents, skills)
│   ├── commands/
│   ├── agents/
│   └── skills/
├── models/
├── dbt_project.yml
└── ...
```

No npm, no CLI — just Cursor and this folder.

---

## 2. Use in Cursor

1. Open your dbt project in Cursor.
2. Open Agent (Composer): **Cmd+I** (Mac) or **Ctrl+I** (Windows/Linux).
3. In chat, type **`/`** — you should see: `pull`, `plan`, `execute-plan`, `review`, `pr`, `launch`, `help`.
4. **Attach the spec:** If your team keeps the Autopilot spec in a `docs/` folder, type **@docs** and select that folder so the agent has the full rules (Git, PR, classification).

---

## 3. Run your first task

**Full flow (one command):**

```
/launch TSK-123
```

Replace `TSK-123` with your JIRA task ID. The agent will: pull task → classify → plan (if needed) → execute → review → open PR.

**Step by step (if you prefer):**

```
/pull TSK-123
/plan
/execute-plan
/review
/pr
```

---

## 4. PR template, SQL guidelines, and other guides

**These live in your dbt project repo.** Put them in the same repo where you run Autopilot, for example:

- **PR template:** `.github/PULL_REQUEST_TEMPLATE.md` or `docs/pr-template.md`
- **SQL style guide:** `docs/sql-style.md`
- **Linter/config:** e.g. `.sqlfluff`

Autopilot uses them when you run `/pr` or `/review`; if missing, it uses a fallback.

---

## 5. Rules to remember

- **One task → one branch.** Branch name = task ID (e.g. `TSK-123`).
- **Never `git add .`** — the agent will stage only explicit files.
- **PR is the contract.** Autopilot opens the PR; a human approves and merges.
- **If something fails** — the agent stops and reports; fix and re-run the step.

---

## 6. Where is the full spec?

The full Autopilot spec (principles, classification L0–L3, Git rules, failure modes) lives in **@docs** in this repo:

- `00_project_overview.md`
- `01_task_classification.md`
- `02_autopilot_commands.md`
- `03_failures_git_state.md`

Use **@docs** in Cursor chat when working with Autopilot so the agent has the full context.

---

## 7. Need help?

- Run **`/help`** in chat for the command reference.
- Read **README.md** in the `autopilot/` folder for install options and artifacts.
- Ask your team for the link to the `docs/` folder or repo that contains the spec.
