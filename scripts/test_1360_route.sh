#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
source_include="$repo_root/upstream/etaHEN/Source Code/include"
if [[ ! -f "$source_include/port_toolbox_route.hpp" ]]; then
  echo "Initialize and patch the source first with scripts/codex-cloud-setup.sh." >&2
  exit 1
fi
if ! command -v g++ >/dev/null 2>&1; then
  echo "g++ is required for the host route regression test." >&2
  exit 1
fi

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT
g++ -std=c++17 -Wall -Wextra -Werror \
  -I "$source_include" \
  "$repo_root/tests/test_1360_route.cpp" \
  -o "$tmpdir/test_1360_route"
"$tmpdir/test_1360_route"
echo "13.60 Debug Settings route regression passed."
