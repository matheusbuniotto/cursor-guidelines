# Autopilot — Analytics Engineering kit for Cursor

Autopilot reduces manual AE work in large dbt environments by safely executing repetitive, well-scoped tasks end-to-end. It is **Cursor-native**: Commands, Agents, and Skills live in `.cursor/` and work with Cursor’s Agent (Composer).

**Spec:** Full behavior is defined in **@docs** — `00_project_overview.md`, `01_task_classification.md`, `02_autopilot_commands.md`, `03_failures_git_state.md`.

---

## Install (share & onboard)

**Option A — AI-assisted install (recommended for new users)**

1. Send to Cursor or any AI: *"Follow this guide and install Autopilot for me: [link to this repo or to autopilot/INSTALL.md]"*
2. The AI will ask **Project only or global?** then copy the kit. Full instructions for the AI are in **[INSTALL.md](INSTALL.md)**.

**Option B — Script install**

Run from repo root: `./autopilot/install.sh` — prompts for **Project (current dir) or Global (~/.cursor/)** then copies. Non-interactive: `./autopilot/install.sh --project` or `--global`.

**Option C — Copy into your dbt repo (manual)**

1. Copy the **`.cursor/`** folder from this `autopilot/` directory into your **dbt project root**.
2. In Cursor, open your dbt project. Commands and skills are available immediately.
3. In chat, reference the spec with **@docs** (attach the repo’s `docs/` folder) so the agent has the full Autopilot spec.

**Option D — Clone the whole repo**

1. Clone this repo.
2. In Cursor, **File → Open Folder** and open the cloned repo (or your dbt repo with `autopilot/.cursor/` copied in).
3. Use **@docs** to attach `docs/` for the spec.

**Option E — Team shared repo**

1. Create a team repo that contains only `autopilot/.cursor/` (or this full repo).
2. New members: clone the repo and copy `autopilot/.cursor/` into their dbt project root.
3. Document in your team wiki: “Copy `autopilot/.cursor/` into your dbt repo; in Cursor use @docs for the spec.”

---

## Quick start

1. **One command (default):** In Cursor chat, type `/launch TSK-123` (replace with your JIRA task ID).  
   The agent runs: pull → plan → execute-plan → review → pr.

2. **Step by step:**  
   - `/pull TSK-123` — Fetch task, sync release branch, create branch `TSK-123`.  
   - `/plan` — Classify (L0–L3), generate plan if needed.  
   - `/execute-plan` — Execute work (use `--phase=1` or `--all` for L3).  
   - `/review` — Run dbt build/tests; block PR if failures.  
   - `/pr` — Open PR (template); Autopilot never merges.

3. **Help:** `/help` — Show command reference.

---

## What’s inside `.cursor/`

| Folder     | Contents |
|-----------|----------|
| `commands/` | `pull`, `plan`, `execute-plan`, `review`, `pr`, `launch`, `help` — slash commands. |
| `agents/`   | `classifier`, `planner`, `executor`, `verifier` — subagents the main Agent can delegate to. |
| `skills/`   | `task-pull`, `classification`, `dbt-validate`, `pr-template` — reusable skills for task init, classification, validation, PR. |
| `rules/`    | `autopilot.mdc` — guardrails (no `git add .`, one task one branch, PR is contract, never merge); applied when editing SQL/models or `.autopilot/`. |

All commands and skills reference **@docs** for the full spec (principles, Git rules, failure modes, state).

---

## PR template, SQL guidelines, and other guides

**These live in your dbt project repo**, not in this kit. Autopilot reads them from the workspace when you run `/pr` or `/review`. Put them in your dbt repo, for example:

- **PR template:** `.github/PULL_REQUEST_TEMPLATE.md` or `docs/pr-template.md`
- **SQL style guide:** `docs/sql-style.md` (or similar)
- **Linter/config:** e.g. `.sqlfluff`, project docs

If present, the agent uses them; if not, it falls back to built-in structure.

---

## Rules (from @docs)

- **Git:** Never `git add .`; always stage explicit paths. One task → one branch; branch name = task ID.
- **PR:** The PR is the contract; Autopilot never merges; human approval required.
- **Stops:** On ambiguity, failure, or missing confirmation — stop and persist state in `.autopilot/`.

---

## Artifacts

Autopilot writes under `.autopilot/` (create this if missing):

- `task.json` — After pull (task metadata).
- `classification.json` — After plan (L0–L3, rationale).
- `state.json` — Progress, commits, summary, stage.
- `plan.yml` — Only for L2/L3 tasks.

Add `.autopilot/` to `.gitignore` if you prefer not to commit state (optional).

---

## Onboarding checklist (for your team)

- [ ] Copy `autopilot/.cursor/` into the dbt project root.
- [ ] In Cursor, open the dbt project and type `/help` to confirm commands appear.
- [ ] Attach **@docs** (repo `docs/` folder) in chat when using Autopilot so the agent has the spec.
- [ ] Run `/launch TSK-XXX` once with a real or test task to validate flow.
- [ ] Ensure JIRA (or manual task input), Git, and dbt are available in the environment.
