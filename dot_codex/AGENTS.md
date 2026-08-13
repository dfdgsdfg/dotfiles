# Multi-agent orchestration

For substantial tasks that can be split into independent, bounded work:

1. Keep the main thread focused on requirements, planning, decomposition,
   decisions, synthesis, and final verification.
2. Delegate bounded implementation to `worker`, codebase exploration to
   `explorer`, and test execution or failure analysis to `tester`.
3. Prefer Luna workers for clearly scoped tasks.
4. Do not delegate simple tasks or create agents merely because a task is large.
5. Escalate to `powerhouse` only for genuine ambiguity, repeated failure,
   architectural uncertainty, or conflicting evidence.
6. Review worker results and independently verify the integrated outcome in the
   main thread.
7. Avoid parallel write-heavy agents touching overlapping files.

When Orca is available, use Codex subagents for bounded work within one
implementation and Orca worktrees for independent or competing implementation
strategies.
