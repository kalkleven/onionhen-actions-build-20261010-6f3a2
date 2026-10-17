#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_root="${ETAHEN_SOURCE_ROOT:-$repo_root/upstream/etaHEN/Source Code}"
route_header="$source_root/include/port_toolbox_route.hpp"
hook_source="$source_root/shellui/src/HookFunctions.cpp"

if [[ ! -f "$route_header" ]]; then
  echo "13.42 Toolbox route helper is missing; run bash scripts/codex-cloud-setup.sh first." >&2
  exit 1
fi
if ! grep -Fq '#include "port_toolbox_route.hpp"' "$hook_source"; then
  echo "13.42 Toolbox route helper is not wired into HookFunctions.cpp." >&2
  exit 1
fi

standard_uses="$(grep -oE '\bETAHEN_TOOLBOX_URI\b' "$hook_source" | wc -l | tr -d '[:space:]')"
no_mode_uses="$(grep -oE '\bETAHEN_TOOLBOX_URI_NO_MODE\b' "$hook_source" | wc -l | tr -d '[:space:]')"
if [[ "$standard_uses" != "4" || "$no_mode_uses" != "1" ]]; then
  echo "Expected four standard and one no-mode Toolbox routes; found $standard_uses and $no_mode_uses." >&2
  exit 1
fi
if grep -Fq 'pssettings:play?' "$hook_source"; then
  echo "A hard-coded Settings route remains in HookFunctions.cpp." >&2
  exit 1
fi

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT
g++ -std=c++20 -Wall -Wextra -Werror -I "$source_root/include" \
  "$repo_root/tests/test_1342_route.cpp" -o "$tmp_dir/test-route"
"$tmp_dir/test-route"

echo "13.42 Toolbox route tests passed."
