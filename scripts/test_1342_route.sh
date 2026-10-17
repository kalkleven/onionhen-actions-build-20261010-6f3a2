#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_root="${ETAHEN_SOURCE_ROOT:-$repo_root/upstream/etaHEN/Source Code}"
route_header="$source_root/include/port_toolbox_route.hpp"

if [[ ! -f "$route_header" ]]; then
  echo "13.42 Toolbox route helper is missing; run bash scripts/codex-cloud-setup.sh first." >&2
  exit 1
fi

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT
g++ -std=c++20 -Wall -Wextra -Werror -I "$source_root/include" \
  "$repo_root/tests/test_1342_route.cpp" -o "$tmp_dir/test-route"
"$tmp_dir/test-route"

echo "13.42 Toolbox route tests passed."
