---
name: classification
description: Use when classifying an AE task as L0–L3 — apply decision tree and Silver rules from @docs 01_task_classification.md.
---

# Task classification

Use this skill when the user or /plan needs to classify a task (L0–L1–L2–L3) for planning depth.

## When to use

- During /plan to decide if a plan file is needed.
- When user asks "what level is this task?" or "classify this task".

## Inputs (minimal, objective)

- JIRA metadata (type, labels).
- Number of dbt models touched.
- Layer(s) impacted (bronze / silver / gold).
- Downstream dependency count (dbt graph).
- Table size stats, SQL complexity (LOC, join count) if available.

## Decision tree (from @docs 01_task_classification.md)

- No code change → L0
- 1–2 models, no downstream → L0
- 1–2 models, downstream exists → L1
- >2 models, single layer → L2
- Cross-layer / >2 layers → L3
- Silver touched → minimum L1; apply Silver heuristics (size rank, downstream refs, SQL LOC, joins) and escalate if needed.
- Hotfix label → cap at L1. Docs-only → L0.

Classification can only **escalate**, never downgrade.

## Output

Write `.autopilot/classification.json`: level (L0|L1|L2|L3), rationale, models_touched, layers.
