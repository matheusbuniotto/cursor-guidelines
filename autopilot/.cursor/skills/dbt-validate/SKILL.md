---
name: dbt-validate
description: Use when validating dbt work before PR — run dbt build/tests, lint, contracts. Use during /review.
---

# dbt validate

Use this skill when the user or /review needs to validate dbt work before opening a PR.

**SQL guidelines and other guides live in the dbt project repo.** Use the project’s SQL style guide and linter config (e.g. `docs/sql-style.md`, `.sqlfluff`) when running checks.

## When to use

- During /review before /pr.
- User says "validate", "run tests", "dbt build", "check dbt".

## Steps

1. Identify impacted models from `.autopilot/state.json` or git diff.
2. Run `dbt build` (or targeted selection for changed models).
3. Run tests relevant to the change (schema, data, freshness).
4. If project has SQL linter/formatter, run it.
5. If dbt contracts exist, ensure they pass.
6. Report pass/fail; if failed, list failures clearly. Do not open PR until passed or user approves override.

## Rules

- Review failures **block** PR (per @docs).
- Output human-readable summary.
