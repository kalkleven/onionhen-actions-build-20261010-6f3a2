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

route_header="$source_dir/include/port_toolbox_route.hpp"
hook_source="$source_dir/shellui/src/HookFunctions.cpp"
route_patch="$repo_root/patches/13.42/toolbox-route.patch"
if [[ -f "$route_header" ]]; then
  if ! grep -Fq '#include "port_toolbox_route.hpp"' "$hook_source"; then
    echo "The 13.42 route helper exists, but HookFunctions.cpp is not patched." >&2
    exit 1
  fi
  all_route_uses="$(grep -o 'ETAHEN_TOOLBOX_URI' "$hook_source" | wc -l | tr -d '[:space:]')"
  no_mode_uses="$(grep -o 'ETAHEN_TOOLBOX_URI_NO_MODE' "$hook_source" | wc -l | tr -d '[:space:]')"
  if [[ "$all_route_uses" != "5" || "$no_mode_uses" != "1" ]] || grep -Fq 'pssettings:play?' "$hook_source"; then
    echo "The Toolbox route overlay is incomplete." >&2
    exit 1
  fi
  echo "13.42 Toolbox route overlay already applied."
else
  git -C "$upstream_repo" apply --check --directory="Source Code" "$route_patch"
  git -C "$upstream_repo" apply --directory="Source Code" "$route_patch"
  echo "Applied experimental 13.42 Toolbox route overlay."
fi

pager_header="$source_dir/libSelfDecryptor/include/firmware_profile_1342.h"
selfpager_source="$source_dir/libSelfDecryptor/source/selfpager.c"
selfpager_patch="$repo_root/patches/13.42/selfpager.patch"
if [[ -f "$pager_header" ]]; then
  if ! grep -Fq '#include "../include/firmware_profile_1342.h"' "$selfpager_source" ||
     ! grep -Fq 'etahen_port_pager_table_offset(fwver << 16)' "$selfpager_source"; then
    echo "The 13.42 pager-table header exists, but selfpager.c is not patched." >&2
    exit 1
  fi
  echo "13.42 Game/App dumper pager-table overlay already applied."
else
  git -C "$upstream_repo" apply --check --directory="Source Code" "$selfpager_patch"
  git -C "$upstream_repo" apply --directory="Source Code" "$selfpager_patch"
  echo "Applied experimental 13.42 Game/App dumper pager-table overlay."
fi

boot_abi_header="$source_dir/shellui/include/port_boot_abi.hpp"
mono_abi_header="$source_dir/shellui/include/port_mono_abi.hpp"
hooked_funcs="$source_dir/shellui/include/HookedFuncs.hpp"
prx_source="$source_dir/shellui/src/prx.cpp"
boot_abi_patch="$repo_root/patches/13.42/boot-abi.patch"
if [[ -f "$boot_abi_header" ]]; then
  if [[ ! -f "$mono_abi_header" ]] ||
     ! grep -Fq '#include "port_boot_abi.hpp"' "$prx_source" ||
     ! grep -Fq 'uri_boot_hook_nullable' "$hooked_funcs" ||
     ! grep -Fq 'uri_boot_hook_nullable' "$source_dir/shellui/src/HookFunctions.cpp" ||
     ! grep -Fq 'port_boot_abi(count,' "$prx_source"; then
    echo "The ShellUI Boot ABI headers exist, but the runtime selector is incomplete." >&2
    exit 1
  fi
  echo "13.42 ShellUI Boot ABI overlay already applied."
else
  git -C "$upstream_repo" apply --check --directory="Source Code" "$boot_abi_patch"
  git -C "$upstream_repo" apply --directory="Source Code" "$boot_abi_patch"
  echo "Applied experimental ShellUI Boot ABI overlay."
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
  bash "$repo_root/scripts/test_1342_offsets.sh"
  bash "$repo_root/scripts/test_1342_route.sh"
  bash "$repo_root/scripts/test_1342_boot_abi.sh"
else
  echo "Skipping C++ host tests: g++ is not installed."
fi

host_c_compiler="${CC:-gcc}"
if command -v "$host_c_compiler" >/dev/null 2>&1; then
  bash "$repo_root/scripts/test_1342_selfpager.sh"
else
  echo "Skipping pager-table host test: C compiler not found ($host_c_compiler)."
fi

if [[ -n "${PS5_PAYLOAD_SDK:-}" ]]; then
  echo "PS5_PAYLOAD_SDK is set."
else
  echo "PS5_PAYLOAD_SDK is not set; the source is ready, but the PS5 target build is not configured."
fi

echo "Codex Cloud source setup complete."
