# Cursor Docs Guide: Skills, Agents & Commands

Reference distilled from [Cursor Docs](https://docs.cursor.com) for **Skills**, **Agents** (incl. Subagents), and **Commands**. Use this when building Cursor-based workflows (e.g. GSD-style or Analytics Engineer kits).

---

## 1. Commands

**Docs:** [Context → Commands](https://cursor.com/docs/context/commands)

- **What:** Reusable workflows triggered by typing `/` in the chat input. Plain Markdown that describes what the command should do.
- **Where:**
  - **Project:** `.cursor/commands/` (project root)
  - **Global:** `~/.cursor/commands/`
  - **Team:** Cursor Dashboard (Team Content → Commands) — Team/Enterprise only
- **Format:** One `.md` file per command. Filename becomes the command name (e.g. `review-code.md` → `/review-code`).
- **Parameters:** Anything after the command name is passed to the model, e.g. `/commit and pr these changes to address DX-523`.

**Creating commands:**
1. Create `.cursor/commands/` in project root.
2. Add `.md` files with descriptive names (e.g. `setup-feature.md`, `run-tests.md`).
3. Write plain Markdown describing the desired behavior.
4. Commands show up when you type `/` in chat.

**Example layout:**
```
.cursor/
└── commands/
    ├── code-review-checklist.md
    ├── create-pr.md
    ├── run-tests-and-fix.md
    └── setup-new-feature.md
```

---

## 2. Skills

**Docs:** [Context → Skills](https://cursor.com/docs/context/skills)

- **What:** Portable, version-controlled packages that teach the agent how to do domain-specific tasks. Can include instructions plus executable scripts/code.
- **Where (discovery order):**
  - **Project:** `.cursor/skills/`, `.claude/skills/`, `.codex/skills/`
  - **User (global):** `~/.cursor/skills/`, `~/.claude/skills/`, `~/.codex/skills/`
- **Structure:** Each skill is a **folder** with a `SKILL.md` file. Optional: `scripts/`, `references/`, `assets/`.

**Directory layout:**
```
.cursor/
└── skills/
    └── my-skill/
        └── SKILL.md
```

With optional dirs:
```
.cursor/
└── skills/
    └── deploy-app/
        ├── SKILL.md
        ├── scripts/
        │   ├── deploy.sh
        │   └── validate.py
        ├── references/
        │   └── REFERENCE.md
        └── assets/
            └── config-template.json
```

**SKILL.md format:** YAML frontmatter + Markdown body.

| Frontmatter field | Required | Description |
|-------------------|----------|-------------|
| `name` | Yes | Skill id: lowercase, numbers, hyphens only. Must match folder name. |
| `description` | Yes | What the skill does and when to use it (used for relevance). |
| `license` | No | License name or file reference. |
| `compatibility` | No | Environment needs (packages, network, etc.). |
| `metadata` | No | Extra key-value metadata. |
| `disable-model-invocation` | No | If `true`, skill is only applied when you explicitly type `/skill-name`. |

**Example SKILL.md:**
```markdown
---
name: deploy-app
description: Deploy the application to staging or production. Use when the user mentions deployment, releases, or environments.
---

# Deploy App

Deploy using the provided scripts.

## Usage

Run: `scripts/deploy.sh <environment>` (staging or production).

## Pre-deployment

Run: `python scripts/validate.py`
```

- **Scripts:** Put runnable code in `scripts/`. Refer to them in `SKILL.md` with paths relative to the skill root. Agent can execute them when the skill is used.
- **Viewing skills:** Cursor Settings → Rules → “Agent Decides” section.
- **Installing from GitHub:** Rules → Add Rule → Remote Rule (Github) → repo URL.
- **Migration:** Cursor 2.4 has `/migrate-to-skills` to turn dynamic rules and slash commands into skills.

---

## 3. Agent (Cursor Agent)

**Docs:** [Agent → Overview](https://cursor.com/docs/agent/overview)

- **What:** The main coding assistant (Cmd+I / Ctrl+I). It uses:
  1. **Instructions** — system prompt + [Rules](https://cursor.com/docs/context/rules)
  2. **Tools** — edit files, search codebase/web, run terminal, etc.
  3. **User messages** — your prompts and follow-ups

- **Tools (summary):** Semantic search, search files/folders, web, fetch rules, read/edit files, run shell commands, browser, image generation, ask questions. No hard limit on tool calls per task.
- **Context:** Long chats get summarized; use `/summarize` to trigger summarization. Checkpoints let you undo Agent edits (separate from Git).

---

## 4. Subagents

**Docs:** [Context → Subagents](https://cursor.com/docs/context/subagents)

- **What:** Specialized assistants the main Agent can delegate to. Each subagent has its own context window, does a specific kind of work, and returns a result to the parent.
- **When to use subagents vs skills:**
  - **Subagents:** Long research, parallel workstreams, specialized multi-step work, independent verification. Need context isolation or separate context window.
  - **Skills:** Single-purpose, quick repeatable action (e.g. generate changelog, format), one-shot task, no need for a separate context window.

**Modes:**
- **Foreground:** Parent waits until subagent finishes; result returned immediately.
- **Background:** Parent returns immediately; subagent keeps running.

**Built-in subagents (automatic):**
- **Explore** — codebase search/analysis (large intermediate output).
- **Bash** — runs sequences of shell commands (verbose output isolated).
- **Browser** — browser control via MCP (noisy DOM/screenshots filtered).

**Custom subagents:**
- **Project:** `.cursor/agents/`
- **User:** `~/.cursor/agents/`
- **Format:** One `.md` file per subagent. YAML frontmatter: `name`, `description`. Body = prompt/instructions.

**Example — create a verifier subagent:**
- File: `.cursor/agents/verifier.md`
- Content:
```markdown
---
name: verifier
description: Validates completed work, checks implementations are functional, runs tests, reports what passed vs incomplete.
---

You are a verifier. Validate the work that was just completed.
- Check that implementations are functional.
- Run relevant tests.
- Report what passed and what is incomplete or broken.
```

- **Viewing:** Custom subagents appear in the Agent’s tools; you can confirm by checking `.cursor/agents/`.

**Trade-offs:** Subagents give context isolation and parallelism but use more tokens (each has its own context) and can add latency for small tasks.

---

## 5. Quick reference

| Concept    | Location (project)   | Format / Trigger          |
|-----------|----------------------|---------------------------|
| Commands  | `.cursor/commands/*.md` | `/` + filename (no .md)   |
| Skills    | `.cursor/skills/<name>/SKILL.md` | Auto or `/skill-name`    |
| Subagents | `.cursor/agents/*.md`   | Agent delegates automatically |

---

## 6. Links

- [Rules](https://cursor.com/docs/context/rules) — project/user rules (always apply or by glob).
- [Agent Overview](https://cursor.com/docs/agent/overview) — how Agent works and tools.
- [Subagents](https://cursor.com/docs/context/subagents) — when and how to use them.
- [Skills](https://cursor.com/docs/context/skills) — skill layout and SKILL.md.
- [Commands](https://cursor.com/docs/context/commands) — slash commands.
- [Agent Skills standard](https://agentskills.io) — portable skill format.
