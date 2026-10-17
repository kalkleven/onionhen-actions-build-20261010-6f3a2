#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"

git submodule sync --recursive
git submodule update --init --recursive

upstream_repo="$repo_root/upstream/etaHEN"
source_dir="$upstream_repo/Source Code"
if [[ ! -f "$source_dir/CMakeLists.txt" ]]; then
  echo "etaHEN source was not initialized at: $source_dir" >&2
  exit 1
fi

expected_upstream="5061a85312eb1d2da811269bcb9061e4b01302a1"
actual_upstream="$(git -C "$upstream_repo" rev-parse HEAD)"
if [[ "$actual_upstream" != "$expected_upstream" ]]; then
  echo "Expected pinned etaHEN 2.5B commit $expected_upstream; found $actual_upstream" >&2
  exit 1
fi

profile_header="$source_dir/libhijacker/source/firmware_profile_1342.hpp"
offsets_source="$source_dir/libhijacker/source/offsets.cpp"
port_patch="$repo_root/patches/13.42/offsets.patch"
if [[ -f "$profile_header" ]]; then
  if ! grep -Fq '#include "firmware_profile_1342.hpp"' "$offsets_source"; then
    echo "The 13.42 profile header exists, but the offsets patch is incomplete." >&2
    exit 1
  fi
  echo "13.42 libhijacker profile overlay already applied."
else
  git -C "$upstream_repo" apply --check --directory="Source Code" "$port_patch"
  git -C "$upstream_repo" apply --directory="Source Code" "$port_patch"
  echo "Applied experimental 13.42 libhijacker profile overlay."
fi

echo "etaHEN submodule commit: $actual_upstream"
echo "Checking build tools:"
for tool in cmake ninja clang clang++ xz; do
  if command -v "$tool" >/dev/null 2>&1; then
    printf '  found: %s\n' "$tool"
  else
    printf '  missing: %s\n' "$tool"
  fi
done

if command -v g++ >/dev/null 2>&1; then
  bash "$repo_root/tests/test_1342_offsets.sh"
else
  echo "Skipping host profile tests: g++ is not installed."
fi

if [[ -n "${PS5_PAYLOAD_SDK:-}" ]]; then
  echo "PS5_PAYLOAD_SDK is set."
else
  echo "PS5_PAYLOAD_SDK is not set; the source is ready, but the PS5 target build is not configured."
fi

echo "Codex Cloud source setup complete."
