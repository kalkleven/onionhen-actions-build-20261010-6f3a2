#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_root="${ETAHEN_SOURCE_ROOT:-$repo_root/upstream/etaHEN/Source Code}"
abi_header="$source_root/shellui/include/port_boot_abi.hpp"
mono_header="$source_root/shellui/include/port_mono_abi.hpp"

if [[ ! -f "$abi_header" || ! -f "$mono_header" ]]; then
  echo "13.42 ShellUI Boot ABI helpers are missing; run bash scripts/codex-cloud-setup.sh first." >&2
  exit 1
fi

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT
g++ -std=c++20 -Wall -Wextra -Werror -I "$source_root/shellui/include" \
  "$repo_root/tests/test_1342_boot_abi.cpp" -o "$tmp_dir/test-boot-abi"
"$tmp_dir/test-boot-abi"

echo "13.42 ShellUI Boot ABI tests passed."
