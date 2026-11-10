---
name: context-focus
description: Gather and maintain focused context for large repositories, long documents, extensive tool output, or multi-source investigations while preserving decision-critical evidence. Use when irrelevant volume or repeated reads are crowding the task, not for routine short requests.
---

# Focused context

Optimize what enters context, not the quality of reasoning or validation. Fewer tokens are useful only if the task can still be completed correctly.

## Gather by dependency

- Identify the requested outcome, acceptance criteria, and user constraints. Preserve literal values when exactness matters: paths, versions, identifiers, quotations, flags, units, and explicit exceptions.
- Start with a file/source inventory and bounded searches. Follow the relevant call chain, configuration precedence, schema, or document section; include definitions and callers needed to understand a match. Expand the scope when evidence points outside the initial area.
- Read small files whole when that is clearer or cheaper than repeated snippets. For large inputs, select by task relevance before using a character or line cutoff. A search miss or a bounded excerpt is not proof that omitted material is irrelevant.
- Prefer structured projections of large results: select relevant fields and records, retain counts and provenance, and keep raw evidence available when it is needed for verification. Avoid printing base64, dependency trees, generated bundles, or entire databases into the conversation.
- Keep the full diagnostic chain around a failure: command, working directory/runtime, exit status, causal error, and relevant surrounding output. If output is truncated, narrow or page it before reaching a conclusion. Do not discard failures in favor of the latest successful run.

## Reuse without making stale claims

Retain a compact working map of relevant sources and decisions; do not reread unchanged material merely to fill context. Recheck mutable files after edits, generated files after regeneration, and external state before relying on it for a new action. Distinguish observed facts, source claims, and hypotheses. Preserve conflicting evidence until resolved.

For work delegated under existing authorization, pass the bounded objective, constraints, relevant artifacts, and expected evidence. Keep shared requirements intact. Do not create additional agents merely to reduce token counts; delegate only when useful and permitted.

## Quality gate

Before editing or concluding, ask whether the reduced view still explains the behavior and covers the acceptance criteria. If a missing detail could change the answer, retrieve it rather than infer it from the summary. Keep useful tests and runtime checks; do not reduce their coverage to save context. Do not silently switch models, disable thinking, reduce context/output limits, or select weaker tools as a context optimization.

This skill changes information handling, not user authorization, task scope, model choices, or source-of-truth precedence. Use native conversation state for working notes. Write a persistent artifact only when the task needs one and its location is authorized; do not put routine checkpoints in the user's long-term memory.
