# Subagent routing & cost-efficient reasoning policy

This global policy governs how the Main session delegates work across subagents and
reasoning tiers. Goal: solve each task at the **lowest capability/effort that reliably
works**, escalating only on real difficulty — never merely because a task is large.

## Main session

Main runs at **Opus / high** (pinned via `settings.json`: `model: opus`, `effortLevel: high`).
Main's job is judgment, not grunt work:

- Understand requirements; plan; decompose tasks.
- Make architecture decisions and route work to the right subagent.
- Synthesize subagent results; replan; make final decisions.

Main should **not** personally do broad searches or repetitive implementation — delegate
those. Main does **not** default to Opus **xhigh**; deep reasoning is escalated to a
dedicated agent (see ladder). Fast mode is **not** Main's default.

## The agents (model / effort are enforced in each agent's frontmatter)

| Agent          | Model / effort | Use for |
|----------------|----------------|---------|
| `explorer`     | Sonnet / medium | Read-only investigation: search, call paths, deps, config, tests, evidence. |
| `worker`       | Sonnet / medium | Clearly-scoped implementation, bug fixes, refactors, tests, routine edits. |
| `verifier`     | Sonnet / high   | Independent verification (correctness, regressions, edge cases). |
| `hard-worker`  | Opus / high     | Well-defined but hard implementation; used after Sonnet worker fails. |
| `hard-reasoner`| Opus / xhigh    | Hard reasoning/analysis unsolved at Opus/high; conflicting root causes. |
| `powerhouse`   | Fable / high    | Top-tier exception: architectural/root-cause uncertainty, conflicting agents, repeated failure. |

## Default / unspecified subagents → prefer Sonnet / medium

When a task needs a generic subagent and no stronger tier is clearly justified, route it to
`explorer` (investigation) or `worker` (implementation) — both **Sonnet / medium**. Do **not**
spin up Opus or Fable for generic exploration/implementation. Prefer a **specialized custom
agent** over a generic/built-in one when a fitting one exists.

> Note: Claude Code has no settings key that forces *auto-spawned generic* subagents to a
> given model (the only lever, `CLAUDE_CODE_SUBAGENT_MODEL`, would also override the Opus/Fable
> agents, so it is intentionally not set). This section is therefore **behavioral guidance**,
> not hard configuration. The per-agent tiers above **are** hard-configured in frontmatter.

## Orchestration rules

- Main concentrates on planning and judgment; delegate execution.
- **Parallelize** read-heavy, independent work (multiple `explorer` runs).
- Do **not** run write-heavy agents that touch overlapping files concurrently.
- Run `verifier` **independently** of the agent that implemented the work.
- **Task size alone never justifies Opus/Fable or higher effort.** Only genuine difficulty does.
- If Sonnet fails but the task is well-defined → `hard-worker` (Opus/high).
- If the reasoning itself is hard → `hard-reasoner` (Opus/xhigh).
- If architecture/root-cause itself is unclear → `powerhouse` (Fable/high).

## Escalation ladder (take the lowest rung that works; you may enter directly at the right rung)

```
Sonnet / medium        ← most exploration & implementation
   ↓ (independent check)
Sonnet / high          ← verification
   ↓ clear but hard, Sonnet worker failed
Opus / high            ← hard-worker
   ↓ judgment still uncertain
Opus / xhigh           ← hard-reasoner
   ↓ architecture / root-cause uncertainty
Fable / high           ← powerhouse
   ↓ only when truly exceptional
Fable / xhigh or max   ← per-case, never a default
```

You need not pass through every rung — route directly to the appropriate level for the
task's difficulty, but always prefer the lowest capability/effort that will reliably solve it.

## Fast mode

Fast is orthogonal to the reasoning tier and is **not** a global default. Every role above
runs **Standard** by default. Enable `/fast` only for a specific session/worker when
human-perceived interactive latency is the real bottleneck. Never make Opus/Fable Fast a default.
