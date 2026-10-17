#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_root="${ETAHEN_SOURCE_ROOT:-$repo_root/upstream/etaHEN/Source Code}"
header="$source_root/libSelfDecryptor/include/firmware_profile_1342.h"
selfpager="$source_root/libSelfDecryptor/source/selfpager.c"

if [[ ! -f "$header" ]]; then
  echo "13.42 pager-table profile is missing; run bash scripts/codex-cloud-setup.sh first." >&2
  exit 1
fi
if ! grep -Fq 'etahen_port_pager_table_offset(fwver << 16)' "$selfpager"; then
  echo "Game/App dumper pager-table profile is not wired into selfpager.c." >&2
  exit 1
fi

compiler="${CC:-gcc}"
if ! command -v "$compiler" >/dev/null 2>&1; then
  echo "Host C compiler not found: $compiler" >&2
  exit 1
fi
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT
"$compiler" -std=c11 -Wall -Wextra -Werror -I "$source_root/libSelfDecryptor/include" \
  "$repo_root/tests/test_1342_selfpager.c" -o "$tmp_dir/test-selfpager"
"$tmp_dir/test-selfpager"

echo "13.42 Game/App dumper pager-table tests passed."
