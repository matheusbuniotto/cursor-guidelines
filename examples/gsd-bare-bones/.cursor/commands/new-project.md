# Initialize a new project (bare-bones GSD-style)

1. **Check:** If `.planning/PROJECT.md` already exists, tell the user the project is already initialized and suggest `/plan-phase 1` or viewing `.planning/ROADMAP.md`.

2. **Ask:** "What do you want to build?" Wait for the user's answer. Ask 1–3 short follow-up questions if needed (goals, constraints, tech stack).

3. **Create directory:** Ensure `.planning/` exists.

4. **Write PROJECT.md** in `.planning/PROJECT.md` with:
   - Title and one-paragraph description of the project
   - Main goals (bullets)
   - Constraints or out-of-scope (if any)
   - Last updated date

5. **Optional:** If the user wants requirements and roadmap:
   - Create `.planning/REQUIREMENTS.md` with a short list of v1 requirements (bullets or checkboxes).
   - Create `.planning/ROADMAP.md` with 3–6 phases (phase number, name, one-line goal each).

6. **Commit:** Run `git add .planning/` and `git commit -m "chore: initialize project"` (if git is used).

7. **Reply:** Summarize what was created and suggest next step: run `/plan-phase 1` to plan the first phase.
