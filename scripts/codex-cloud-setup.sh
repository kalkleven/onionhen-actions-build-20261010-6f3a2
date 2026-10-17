#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"

git submodule sync --recursive
git submodule update --init --recursive

upstream_repo="$repo_root/upstream/etaHEN"
expected_upstream="f59d709228954918e61e8e1b7e64d4b70b24be2f"
actual_upstream="$(git -C "$upstream_repo" rev-parse HEAD)"
if [[ "$actual_upstream" != "$expected_upstream" ]]; then
  echo "Expected etaHEN 13.60 r3 commit $expected_upstream; found $actual_upstream" >&2
  exit 1
fi

overlay="$repo_root/patches/13.60/debug-settings.patch"
route_header="$upstream_repo/Source Code/include/port_toolbox_route.hpp"
bootstrap_source="$upstream_repo/Source Code/bootstrapper/source/main.cpp"
settings_header="$upstream_repo/Source Code/daemon/include/globalconf.hpp"
hook_source="$upstream_repo/Source Code/shellui/src/HookFunctions.cpp"
if grep -Fq 'pssettings:play?function=debug_settings")' "$route_header" &&
   grep -Fq 'toolbox_card_start' "$bootstrap_source" &&
   grep -Fq 'StartOpts start_opt = TOOLBOX;' "$settings_header" &&
   ! grep -Fq 'Toolbox has its own home-screen card' "$hook_source"; then
  echo "13.60 Debug Settings and startup overlay already applied."
else
  git -C "$upstream_repo" apply --check "$overlay"
  git -C "$upstream_repo" apply "$overlay"
  echo "Applied the 13.60 Debug Settings and startup overlay."
fi

bash "$repo_root/scripts/test_1360_route.sh"
bash "$repo_root/scripts/test_1360_overlay.sh"

echo "etaHEN 13.60 r3 source setup complete."
echo "For the PS5 build requirements, follow upstream/etaHEN/BUILDING.md."
