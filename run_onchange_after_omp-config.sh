#!/bin/sh
# Apply the managed omp (Oh My Pi) routing policy.
#
# config.yml is app-owned — omp rewrites it whenever a setting changes — so it is
# deliberately NOT a chezmoi-managed file. Instead we let omp write its own config
# via `omp config set`, which touches only these keys and preserves everything else
# on the machine. Re-runs whenever this script's contents change.
#
# Policy: main thread on the reasoning model, delegated subagent work on the cheap
# model. Review/design agents keep their bundled (reasoning) defaults.

set -eu

command -v omp >/dev/null 2>&1 || exit 0

PROVIDER="omniroute-deepseek"
BULK="$PROVIDER/agent/bulk"
CHEAP="$PROVIDER/agent/cheap"

# Main = bulk; @smol/@task subagents = cheap; @slow stays bulk (also the TUI's
# slow cycling slot, and the bundled reviewer's declared role).
omp config set modelRoles \
  "{\"default\":\"$BULK\",\"smol\":\"$CHEAP\",\"slow\":\"$BULK\",\"task\":\"$CHEAP\"}" >/dev/null

omp config set enabledModels "[\"$CHEAP\",\"$BULK\"]" >/dev/null

omp config set defaultThinkingLevel high >/dev/null
omp config set retry.enabled true >/dev/null
omp config set retry.maxRetries 1 >/dev/null

# Show which model each spawned task actually resolved to.
omp config set task.showResolvedModelBadge true >/dev/null

echo "omp: routing policy applied (main=$BULK, delegated=$CHEAP)"
