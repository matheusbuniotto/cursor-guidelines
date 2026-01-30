# Autopilot plan — Classify task and generate plan if needed

**Spec:** @docs → `02_autopilot_commands.md` (§5), `01_task_classification.md`, `03_failures_git_state.md`.

Classification **always** happens here. Planning is lazy: L0/L1 no plan file; L2 → plan.yml; L3 → milestone + phases.

## Steps

1. **Load context**  
   Read `.autopilot/task.json` (if present). Inspect git diff and dbt project: models touched, layers (bronze/silver/gold), downstream count.

2. **Classify task (L0–L3)**  
   Apply decision tree from @docs `01_task_classification.md`:
   - No code change → L0
   - 1–2 models, no downstream → L0
   - 1–2 models, downstream → L1
   - >2 models, single layer → L2
   - Cross-layer / >2 layers → L3  
   Silver layer: minimum L1; apply Silver heuristics (table size, downstream refs, SQL LOC, join count) and escalate if needed. Classification can only escalate, never downgrade.

3. **Write classification**  
   Write `.autopilot/classification.json`: level (L0|L1|L2|L3), rationale, models_touched, layers.

4. **Planning by level**  
   - **L0:** No plan artifact. Optional one-line inline plan in state.
   - **L1:** Inline plan (short steps) in `.autopilot/state.json` or PR description later; no plan.yml.
   - **L2:** Generate single `plan.yml` (ordered steps, scope, done-when).
   - **L3:** Generate milestone with phases; multiple plan files or phased plan.yml. If escalation from L2→L3, **soft stop**: ask user to confirm before generating.

5. **Update state**  
   Update `.autopilot/state.json`: stage "plan", classification level, plan path (if any), phases (if L3).

6. **Reply**  
   Report level and outcome (no plan / inline / plan.yml / phases). Next: `/ae-autopilot:execute-plan` (or `/ae-autopilot:execute-plan --phase=1` for L3).
