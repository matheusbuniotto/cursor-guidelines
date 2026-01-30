# Plan a single phase (bare-bones GSD-style)

You receive a phase number (e.g. 1, 2). Anything after the command name is the phase number or context.

1. **Resolve phase number:** From the user message, get the phase number N. If missing, ask.

2. **Load context:** Read `.planning/PROJECT.md` and, if present, `.planning/ROADMAP.md` and `.planning/REQUIREMENTS.md`. Identify the goal and scope for phase N.

3. **Create phase directory:** `.planning/phases/NN-name/` (e.g. `01-foundation`). Use a short slug from the roadmap or "phase-N".

4. **Write 1–3 plan files:** Create `.planning/phases/NN-name/NN-01-PLAN.md`, optionally `NN-02-PLAN.md`, etc. Each plan file should contain:
   - **Goal:** One sentence
   - **Tasks:** 3–7 concrete, ordered steps (file paths, function names, or clear actions)
   - **Done when:** One or two acceptance criteria

5. **Commit:** `git add .planning/phases/` and `git commit -m "docs: plan phase N"`.

6. **Reply:** List the plans created and suggest running `/execute-phase N` to run them.
