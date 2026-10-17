#!/usr/bin/env bash
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
source_root="$repo_root/upstream/etaHEN/Source Code"
route_header="$source_root/include/port_toolbox_route.hpp"
hook_source="$source_root/shellui/src/HookFunctions.cpp"
toolbox_xml="$source_root/shellui/assets/etaHEN_toolbox.xml"
bootstrap_source="$source_root/bootstrapper/source/main.cpp"
build_script="$repo_root/upstream/etaHEN/scripts/build-bootstrapper.mjs"
card_helper="$repo_root/upstream/etaHEN/port/toolbox-card.cpp"
games_source="$source_root/util/source/gameslist.cpp"
fpkg_source="$source_root/bootstrapper/Byepervisor/hen/src/main.cpp"

grep -Fq 'pssettings:play?mode=settings&function=debug_settings")' "$route_header"
grep -Fq 'pssettings:play?function=debug_settings")' "$route_header"
grep -Fq 'void patch_bundle_strings(' "$hook_source"
if grep -Fq 'Toolbox has its own home-screen card' "$hook_source"; then
  echo "13.60 bundle branding is still disabled." >&2
  exit 1
fi

grep -Fq 'id="id_download_store"' "$toolbox_xml"
grep -Fq 'id="id_ps5_backups"' "$toolbox_xml"
grep -Fq 'id == "id_download_store"' "$hook_source"
grep -Fq '"id_ps5_backups"' "$games_source"

grep -Fq 'toolbox_card_remove_start' "$bootstrap_source"
if grep -Fq 'toolbox_card_start' "$bootstrap_source"; then
  echo "The main payload still embeds the card installer." >&2
  exit 1
fi
grep -Fq "build/toolbox-card-remove.elf" "$build_script"
grep -Fq 'toolbox_card_remove:cardPath' "$build_script"
grep -Fq '#ifdef ETAHEN_CARD_REMOVE' "$card_helper"
grep -Fq 'if(!S_ISDIR(st.st_mode)||!owned())' "$card_helper"

grep -Fq 'apply_fpkg_hooks();' "$fpkg_source"
echo "13.60 overlay checks passed (Store, webMAN, fPKG, Debug Settings, card cleanup)."
