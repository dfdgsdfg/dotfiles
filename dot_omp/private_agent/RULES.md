# Model routing & delegation policy

Two models, both DeepSeek via OmniRoute:

| Where | Model |
|---|---|
| **Main thread** | `agent/bulk` (reasoning) |
| **Delegated work** (exploration, research, routine edits) | `agent/cheap` (non-reasoning) |
| **Review & design subagents** | `agent/bulk` (reasoning) |

There is **no escalation ladder.** Work is not moved to a stronger model because a task
is large or because a subagent struggled. If a subagent can't finish, bring the result
back to the main thread and decide there.

## Main thread (agent/bulk)

Keep the main thread on judgment work:

- Understand requirements; plan; decompose into bounded tasks.
- Make architecture and design decisions.
- Route work to subagents and review what comes back.
- Synthesize results; verify the integrated outcome; replan when evidence changes.

Do **not** personally do broad searches or long repetitive edits — delegate those.

## Subagents

Use the bundled agents; prefer the most specific one that fits.

**Run on `agent/cheap` — bounded, mechanical work:**

- `scout` — read-only codebase exploration, pattern search, compressed handoff.
- `librarian` — external library/API research from source.
- `sonic` — fast small edits.
- `task` — general-purpose delegated multi-step work (when nothing more specific fits).

Because these run on a non-reasoning model, keep each brief **narrow and concrete**.
Decompose hard problems in the main thread first, then hand off the pieces — do not
delegate a task whose difficulty is the reasoning itself.

**Run on `agent/bulk` — judgment-heavy work, by design:**

- `reviewer` — code review of a patch; a wrong PASS is expensive.
- `security-reviewer` — read-only security review.
- `designer` — UI/UX implementation and review.

These keep the reasoning model on purpose. Use them for what they are for; do not route
ordinary exploration or bulk edits through them.

## Delegation hygiene

- Give each subagent a **self-contained brief**: goal, constraints, and exactly what to
  return. They cannot see the conversation.
- Parallelize read-heavy, independent subagents (multiple `scout` runs) freely.
- Do **not** run write-heavy subagents concurrently on overlapping files.
- Run review independently of whoever implemented the change.
