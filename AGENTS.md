# Project instructions

## Goal

Adapt official etaHEN 2.5B for firmware 13.42 while preserving the upstream Toolbox and Game Options feature set.

## Source baselines

- Official etaHEN is pinned in upstream/etaHEN at tag 2.5B, commit 5061a85312eb1d2da811269bcb9061e4b01302a1.
- The community multi-firmware reference is pinned in references/etaHEN-13.42-reference at commit 89123ffbc9d14a4515c74800b00124595de60348.
- Use the reference to understand firmware profiles, startup/runtime compatibility, and Toolbox route selection. Do not import its unrelated feature changes by default.
- Keep FEATURES.md aligned to official etaHEN 2.5B. Do not move the official source baseline to another release unless the user asks.

## Firmware work

- Record the source of each firmware compatibility change; do not guess fingerprints, bundle hashes, route behavior, or low-level address data.
- Keep feature visibility and firmware compatibility separate: a feature being present in source does not prove it loads on 13.42.
- The community reference's own manifest labels its 13.42 profile as not hardware-confirmed. Treat it as a source lead, not proof.
- Preserve the official Debug Settings / Toolbox and per-game menu behavior unless a change is required for 13.42 and supported by source evidence.
- Record what was inspected, what was built, and whether a real console test was performed.

## Build and verification

- Run bash scripts/codex-cloud-setup.sh before building.
- Source build requires the PS5 Payload SDK. Check its official project instructions before configuring CMake; do not invent SDK paths or compiler flags.
- Run relevant source tests and build checks after a code change.
- Never claim a hardware result unless the user reports that test.

## Licensing and changes

- Preserve upstream copyright and GPL notices and include required attribution for any adopted code.
- Keep new port changes small and traceable. Do not replace upstream files wholesale when a focused patch will do.
