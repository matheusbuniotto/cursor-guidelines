# Execute all plans for a phase (bare-bones GSD-style)

You receive a phase number. Anything after the command name is the phase number or context.

1. **Resolve phase number:** From the user message, get the phase number N. If missing, ask.

2. **Find plans:** List `.planning/phases/` and find the folder for phase N (e.g. `01-foundation`). Read all `NN-MM-PLAN.md` files in that folder in order.

3. **Execute each plan in order:** For each plan file:
   - Read the Goal and Tasks.
   - Perform each task (edit files, run commands, create files). Prefer small, atomic edits.
   - When the plan is done, run `git add -A` and `git commit -m "feat(phase N): <short description>"` (if git is used).

4. **Summarize:** After all plans for the phase, write a short `.planning/phases/NN-name/SUMMARY.md` saying what was implemented and what files changed.

5. **Reply:** Tell the user what was done and suggest the next step (e.g. `/plan-phase N+1` or manual testing).
