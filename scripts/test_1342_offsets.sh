#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_root="${ETAHEN_SOURCE_ROOT:-$repo_root/upstream/etaHEN/Source Code}"
source_file="$source_root/libhijacker/source/offsets.cpp"

if [[ ! -f "$source_root/libhijacker/source/firmware_profile_1342.hpp" ]]; then
  echo "13.42 offset patch is not applied; run bash scripts/codex-cloud-setup.sh first." >&2
  exit 1
fi

compiler="${CXX:-g++}"
if ! command -v "$compiler" >/dev/null 2>&1; then
  echo "Host compiler not found: $compiler" >&2
  exit 1
fi

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

"$compiler" -std=c++20 -I "$repo_root/tests/mock" \
  "$source_file" "$repo_root/tests/test_1342_offsets.cpp" \
  -o "$tmp_dir/test-1342"
"$tmp_dir/test-1342"

"$compiler" -std=c++20 -DTEST_UNSUPPORTED_VERSION \
  -I "$repo_root/tests/mock" "$source_file" \
  "$repo_root/tests/test_1342_offsets.cpp" \
  -o "$tmp_dir/test-unsupported"
"$tmp_dir/test-unsupported" >/dev/null

echo "13.42 profile selection tests passed."

