# Project instructions

## Goal

Inspect etaHEN 2.5B and prepare a careful firmware 13.42 compatibility port, focusing first on where the Toolbox appears: the Settings / Debug Settings area and the per-game options menu.

## Source baseline

- Upstream etaHEN is pinned in upstream/etaHEN at tag 2.5B, commit 5061a85312eb1d2da811269bcb9061e4b01302a1.
- Do not move the submodule to a different release unless the task explicitly asks for it.
- Treat upstream source and release notes as the feature baseline; FEATURES.md is the user-facing test checklist.

## Firmware work

- Do not guess firmware fingerprints, bundle hashes, route behavior, or low-level address data.
- A 13.42 Settings entry needs a confirmed 13.42 Settings bundle fingerprint and a tested ShellUI route. Do not add a guessed version row.
- Keep feature visibility and firmware compatibility separate: a feature being present in source does not prove it loads on 13.42.
- Record what was inspected, what was built, and whether a real console test was performed.

## Build and verification

- Run bash scripts/codex-cloud-setup.sh before building.
- Source build requires the PS5 Payload SDK. Check its official project instructions before configuring CMake; do not invent SDK paths or compiler flags.
- Run the relevant upstream tests and build checks after a code change.
- Never claim a hardware result unless the user reports that test.

## Licensing and changes

- Preserve upstream copyright and GPL notices.
- Keep new port changes small and traceable. Do not replace upstream files wholesale when a focused patch will do.
