# GSD-Style Bare Bones Example (Cursor)

A minimal, Cursor-native version of the [get-shit-done](https://github.com/glittercowboy/get-shit-done) workflow. Uses **Commands**, **Subagents**, and **Skills** only—no installers or external runtimes.

**Purpose:** Template for building similar kits (e.g. Analytics Engineer workflow) with different commands and agents.

## Layout

```
.cursor/
├── commands/          # Slash commands (type / in chat)
│   ├── help.md
│   ├── new-project.md
│   ├── plan-phase.md
│   └── execute-phase.md
├── agents/            # Subagents the main Agent can delegate to
│   ├── planner.md
│   └── executor.md
└── skills/            # Optional: skills the Agent can apply by name
    └── project-setup/
        └── SKILL.md
```

## Quick Start

1. Copy the `.cursor/` folder (or its contents) into your project root.
2. In Cursor chat, type `/` to see commands: `/help`, `/new-project`, `/plan-phase`, `/execute-phase`.
3. Use `/new-project` to initialize; then `/plan-phase 1` and `/execute-phase 1` for the first phase.

## Workflow (Simplified)

1. **`/new-project`** — Ask what to build, create `.planning/PROJECT.md`, optional `REQUIREMENTS.md` and `ROADMAP.md`.
2. **`/plan-phase N`** — Create a small set of atomic plans for phase N (e.g. `.planning/phases/01-*/PLAN.md`).
3. **`/execute-phase N`** — Run the plans (Agent or executor subagent), one task at a time, with commits per task.

No research agents, no verifier, no config.json—just the minimal loop: **define → plan → execute**.

## Customizing for Another Domain (e.g. Analytics Engineer)

- **Commands:** Add/rename e.g. `dbt-run.md`, `document-models.md`, `test-sources.md` and write the Markdown instructions.
- **Agents:** Add e.g. `analytics-planner.md`, `dbt-executor.md` with domain-specific prompts.
- **Skills:** Add skills like `dbt-test/SKILL.md` or `sql-style/SKILL.md` with when-to-use and steps.

**References:** Target application is **Autopilot** (Analytics Engineering). Full spec: @docs — `00_project_overview.md`, `01_task_classification.md`, `02_autopilot_commands.md`, `03_failures_git_state.md`, `references_repos.md`. Cursor platform: [CURSOR-DOCS-GUIDE](../../docs/CURSOR-DOCS-GUIDE.md).
