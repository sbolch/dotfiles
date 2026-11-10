---
name: context-checkpoint
description: Preserve recoverable task state before conversation compaction, a handoff, or resuming a long interrupted task. Create evidence-linked checkpoints that retain requirements, decisions, failures, and remaining work; avoid routine summaries after every short exchange.
---

# Reliable context checkpoints

A checkpoint is an index to evidence plus the state needed to continue. Compression is lossy: preserve irrecoverable details and exact constraints first, and retrieve source material when the summary is insufficient.

## Preserve what controls the next decision

Use the host's native checkpoint or handoff mechanism when available. Scale the structure to the task, covering:

- **Objective and constraints:** original outcome, latest user steering, acceptance criteria, explicit choices, authorization boundaries, and exceptions. Preserve task continuity across turns.
- **Decisions:** chosen approach and the evidence or tradeoff that justified it. Record rejected approaches only when they prevent a repeated failure or explain the current design.
- **Actual state:** completed changes versus proposals; relevant files, branch/worktree and uncommitted changes; external actions already performed; active processes, jobs, session identifiers and outputs needed to resume safely. Include pending user questions or approvals without treating silence as consent.
- **Evidence and verification:** source paths/links, commands with relevant runtime and flags, outcomes, exact actionable error text, and limitations. Separate build/lint success from observable runtime success. A later pass does not erase an unresolved earlier failure.
- **Remaining work:** concrete next actions, blockers, uncertainties, and which source or check will resolve them. Do not mark a task complete merely because a checkpoint was written.

Use exact representations for brittle details such as API fields, schema shapes, versions, paths, constraints, and benchmark conditions. Deduplicate repeated narrative and replace bulky recoverable content with source references. Do not replace a required exact quotation, source asset, original data, or executable patch with a paraphrase. Avoid duplicating credentials or private payloads; refer to their authorized storage locations.

## Verify the checkpoint

Before handing off, compare it with the current objective and latest evidence. Keep unverified assumptions labeled. Make source references usable: absolute local paths or direct URLs, relevant sections/lines where stable, and revision/time information where it matters. If a critical artifact is ephemeral or inaccessible to the recipient, include the necessary bounded content or preserve it in an authorized artifact before relying on a pointer.

Do not impose an arbitrary summary token target if it would omit requirements or causal evidence. If a summary reaches its output limit or stops mid-thought, treat it as incomplete. Retain original history, inspect input plus output against the summarizer's actual total context window, and retry through an authorized mechanism with adequate headroom. Do not overwrite the last valid checkpoint with an unchecked truncated one. Changing model settings requires task authorization and verification; this skill alone does not grant it.

## Resume from evidence

Read the checkpoint, then verify the mutable state needed for the next action. Inspect the relevant current files/diff and live job/service state before repeating an edit, command, or external action. Use the checkpoint to locate evidence, not as proof that old state remains current. Continue unfinished work rather than starting over or silently narrowing the objective.

Keep checkpoints in conversation state by default. Do not edit long-term memory or automatically create project instruction files as part of checkpointing.
