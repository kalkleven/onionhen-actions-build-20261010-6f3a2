# etaHEN 2.5B — PS5 13.42 port workbench

This repository is a Codex workbench for adapting etaHEN 2.5B to firmware 13.42 while preserving the upstream feature set.

The official source is pinned at etaHEN tag 2.5B, commit 5061a85312eb1d2da811269bcb9061e4b01302a1, under `upstream/etaHEN/Source Code`. A separate community multi-firmware source is pinned under `references/etaHEN-13.42-reference` for compatibility research only.

## What is here

- AGENTS.md: project-specific instructions for Codex
- FEATURES.md: upstream feature checklist for your console testing
- PORT_STATUS.md: current evidence and remaining 13.42 work
- PORT_REFERENCE.md: notes on the pinned 13.42 compatibility reference
- patches/13.42/offsets.patch: experimental 13.42 profile overlay for libhijacker
- tests/test_1342_offsets.sh: host test for 13.42 profile selection and unsupported-version rejection
- scripts/codex-cloud-setup.sh: initialize both source repositories, apply the overlay, and check build tools
- upstream/etaHEN: official etaHEN 2.5B source baseline
- references/etaHEN-13.42-reference: pinned community compatibility reference

## Prepare the source

Clone with submodules enabled, or run:

    bash scripts/codex-cloud-setup.sh

The script initializes both source repositories, applies the small 13.42 libhijacker profile overlay, and runs its host-side profile test when g++ is available. It reports whether CMake, Ninja, Clang, xz, and PS5_PAYLOAD_SDK are available. The overlay does not complete the port or produce a payload.

## Create the Codex Cloud environment

Create the environment on ChatGPT web or desktop, select this private repository, and use this install command:

    bash scripts/codex-cloud-setup.sh

Review the setup result and publish the environment. After it is published, open Codex on mobile and select that environment. New environments are created on web or desktop; mobile can start work from a published environment.

## Scope and testing

The checklist records features documented by official etaHEN 2.5B. The tracked overlay adds only the reference-derived libhijacker offsets for 13.42; the reference manifest marks that profile as not hardware-confirmed. Startup, kstuff, ShellUI routing, and the Game Options path still need porting and validation. No 13.42 payload build or console test is included here yet.

Use the upstream project license and notices in upstream/etaHEN/LICENSE. Keep compatibility changes small, attributed, and reviewable.
