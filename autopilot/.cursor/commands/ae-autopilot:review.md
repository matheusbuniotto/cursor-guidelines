# Autopilot review — Validate before PR

**Spec:** @docs → `02_autopilot_commands.md` (§7), `00_project_overview.md` (§4.6), `03_failures_git_state.md`.

Run validations and quality checks. Review failures **block** PR creation.

## Steps

1. **Load context**  
   Read `.autopilot/state.json` and classification. Identify impacted models and layers.

2. **Run checks**  
   **SQL guidelines and other guides live in the dbt project repo.** Look in the workspace for the project’s SQL style guide and lint/format config (e.g. `docs/sql-style.md`, `.sqlfluff`, `docs/`). Follow them when running checks.
   - **dbt:** Run `dbt build` (or targeted selection for changed models). Run tests relevant to the change.
   - **Linting/formatting:** Use the project’s SQL linter/formatter and style guide if present.
   - **Contracts:** If dbt contracts are used, ensure they pass.
   - **Docs:** Ensure docs/metadata updated if logic changed (ask user if new tests/docs needed per @docs).

3. **Evaluate**  
   - If any check fails: **hard stop**. Report failures clearly; do not open PR. User must fix or approve override.
   - If all pass: proceed.

4. **Update state**  
   Update `.autopilot/state.json`: stage "review", review_status: "passed" (or "failed" with reason).

5. **Reply**  
   Report pass/fail. If passed, next: `/ae-autopilot:pr`. If failed, list what to fix.
