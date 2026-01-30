# Autopilot — Install & onboarding guide (for AI assistants)

**User instruction:** Send this to Cursor or any AI: *"Follow this guide and install Autopilot for me: [link to this repo or to this file]"*. The AI will ask a few questions and then perform the install.

**Link to share:**  
`https://github.com/YOUR_ORG/cursor-guidelines` (or your fork) — and point to `autopilot/INSTALL.md` or this file.

---

## Instructions for the AI

You are helping the user install **Autopilot** — a Cursor-based kit for Analytics Engineering (JIRA → Git → dbt → PR). The kit lives in the repo under `autopilot/.cursor/` and must be copied to the user’s Cursor config.

### Step 1: Get the kit

- If the user shared a **repo link**: clone the repo (or confirm they already have it open). The kit is in the **`autopilot/`** directory.
- If the user shared only this **INSTALL.md**: you need the full repo. Ask: *"Do you have the cursor-guidelines repo cloned or the autopilot folder? If not, I can give you a one-line clone command, or you can download the repo and open it in Cursor."*  
  One-line clone: `git clone https://github.com/YOUR_ORG/cursor-guidelines.git && cd cursor-guidelines`

The kit to install is everything inside **`autopilot/.cursor/`** (commands, agents, skills, rules).

### Step 2: Ask the user (install options)

Ask the user **one by one** (or in one message):

1. **Install location**
   - **Project (local)** — Install only in the **current project** (e.g. their dbt repo). Commands/skills/agents apply only when that folder is open in Cursor.  
     → Copy `autopilot/.cursor/` contents into **`<project-root>/.cursor/`** (merge with existing if present).
   - **Global** — Install for **all projects** (user-level). Commands/skills/agents available in every Cursor workspace.  
     → Copy `autopilot/.cursor/` contents into **`~/.cursor/`** (merge with existing if present).

   Ask: *"Install for this project only (recommended for dbt repos), or for all projects (global)?"*  
   - Project only → destination is the **current workspace root** (the folder they have open in Cursor).  
   - Global → destination is **`~/.cursor/`** (user home).

2. **Optional: docs for the agent**
   - If they use the **same repo** for the Autopilot spec (e.g. `docs/00_project_overview.md`, …), tell them: *"When you use Autopilot in chat, attach the **docs** folder with @docs so the agent has the full spec."*  
   - If the spec lives elsewhere, skip or say: *"Point the agent to your Autopilot spec (e.g. @docs) when you run commands."*

### Step 3: Perform the install

1. **Resolve destination**
   - **Project:** Destination = workspace root. If you don’t know it, ask: *"What is the full path of your dbt project (or project where you want Autopilot)?"* Then use `<that-path>/.cursor/`.
   - **Global:** Destination = `~/.cursor/` (expand `~` to the user’s home directory).

2. **Copy the kit (merge)**
   - Source: **`autopilot/.cursor/`** (from the repo they cloned or opened).
   - Copy **contents** of `autopilot/.cursor/` into the destination `.cursor/`:
     - `commands/` → destination `.cursor/commands/` (merge: add files, don’t remove existing).
     - `agents/` → destination `.cursor/agents/` (merge).
     - `skills/` → destination `.cursor/skills/` (merge).
     - `rules/` → destination `.cursor/rules/` (merge).
   - If destination `.cursor/` or a subfolder doesn’t exist, create it.
   - Do **not** delete existing files in the destination; only add or overwrite Autopilot files.

3. **Verify**
   - List what was copied (e.g. commands: pull, plan, execute-plan, review, pr, launch, help).
   - Tell the user: *"In Cursor, open the project (or any project if global), then type **/** in chat — you should see Autopilot commands (e.g. ae-autopilot:pull, ae-autopilot:plan, ae-autopilot:launch). Run **/ae-autopilot:help** for the full list."*

### Step 4: Onboarding (one sentence)

Say: *"Run **/setup** once to create `.autopilot/config.json` (name, email, PR reviewers, team label, JIRA). Then use **/launch TSK-123** (full flow) or **/pull**, **/plan**, **/execute-plan**, **/review**, **/pr** step by step. For full rules, attach **@docs** in chat (the repo’s docs folder)."*

If they want more: point them to **autopilot/ONBOARDING.md** in the repo.

---

## Non-interactive (script) install

If the user prefers a script instead of AI-assisted install:

- From the **repo root**: `./autopilot/install.sh`
- Or from **autopilot/**: `./install.sh`

The script will prompt: **Install to project (current directory) or global (~/.cursor/)?** then copy and merge `autopilot/.cursor/` to the chosen location.

Non-interactive (e.g. CI):  
`./autopilot/install.sh --project` or `./autopilot/install.sh --global`

---

## How GSD does it (reference)

Get Shit Done (GSD) uses:

- **Interactive:** `npx get-shit-done-cc` → prompts for **Runtime** (Claude Code / OpenCode / Gemini / All), then **Location** (Global vs Local).
- **Non-interactive:** `npx get-shit-done-cc --claude --global` or `--local`.
- A **Node.js installer** that copies files into `~/.claude/` or `./.claude/` (or the right path per runtime).

Autopilot is Cursor-only, so we only ask **Location** (project vs global). The rest of the flow (ask → copy → verify) is the same idea.
