#!/usr/bin/env bash
set -euo pipefail

# Extract globally installed pnpm package names via JSON output
packages=()
while IFS= read -r pkg; do
  packages+=("$pkg")
done < <(
  pnpm -g list --json 2>/dev/null \
    | python3 -c "import sys,json; data=json.load(sys.stdin); deps=data[0].get('dependencies',{}); [print(k) for k in deps]"
)

if [[ ${#packages[@]} -eq 0 ]]; then
  echo "No global pnpm packages found."
  exit 0
fi

echo "=== Global pnpm packages ==="
printf '  %s\n' "${packages[@]}"
echo ""

echo "=== Removing all global packages ==="
pnpm remove -g "${packages[@]}"
echo ""

echo "=== Reinstalling all packages ==="
pnpm add -g "${packages[@]}"
echo ""

echo "Done."
