#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"

git submodule sync --recursive
git submodule update --init --recursive

source_dir="$repo_root/upstream/etaHEN/Source Code"
if [[ ! -f "$source_dir/CMakeLists.txt" ]]; then
  echo "etaHEN source was not initialized at: $source_dir" >&2
  exit 1
fi

echo "etaHEN submodule commit: $(git -C "$repo_root/upstream/etaHEN" rev-parse HEAD)"
echo "Checking build tools:"
for tool in cmake ninja clang clang++ xz; do
  if command -v "$tool" >/dev/null 2>&1; then
    printf '  found: %s\n' "$tool"
  else
    printf '  missing: %s\n' "$tool"
  fi
done

if [[ -n "${PS5_PAYLOAD_SDK:-}" ]]; then
  echo "PS5_PAYLOAD_SDK is set."
else
  echo "PS5_PAYLOAD_SDK is not set; the source is ready, but the PS5 target build is not configured."
fi

echo "Codex Cloud source setup complete."
