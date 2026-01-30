---
name: project-setup
description: Use when the user wants to initialize a new project or set up .planning/ with PROJECT.md, REQUIREMENTS.md, and ROADMAP.md.
---

# Project setup

Use this skill when the user says they want to start a new project, define scope, or create project/requirements/roadmap docs.

## When to use

- User says "new project", "initialize", "set up project", "define scope", "create roadmap".
- No `.planning/PROJECT.md` exists yet.

## Steps

1. Ask: "What do you want to build?" and 1–3 follow-ups (goals, constraints, stack).
2. Create `.planning/` and write `PROJECT.md` (title, description, goals, constraints).
3. Optionally add `REQUIREMENTS.md` (v1 list) and `ROADMAP.md` (phases with one-line goals).
4. Suggest next: run `/plan-phase 1` to plan the first phase.

Do not create code or run installs unless the user explicitly asks.
