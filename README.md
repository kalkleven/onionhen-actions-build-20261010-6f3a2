# etaHEN 2.5B — PS5 13.42 port workbench

This repository is a Codex workbench for adapting etaHEN 2.5B to firmware 13.42 while preserving the upstream feature set.

The official source is pinned at etaHEN tag 2.5B, commit 5061a85312eb1d2da811269bcb9061e4b01302a1, under `upstream/etaHEN/Source Code`. A separate community multi-firmware source is pinned under `references/etaHEN-13.42-reference` for compatibility research only.

## What is here

- AGENTS.md: project-specific instructions for Codex
- FEATURES.md: upstream feature checklist for your console testing
- PORT_STATUS.md: current evidence and remaining 13.42 work
- PORT_REFERENCE.md: notes on the pinned 13.42 compatibility reference
- scripts/codex-cloud-setup.sh: initialize both source repositories and check build tools
- upstream/etaHEN: official etaHEN 2.5B source baseline
- references/etaHEN-13.42-reference: pinned community compatibility reference

## Prepare the source

Clone with submodules enabled, or run:

    bash scripts/codex-cloud-setup.sh

The script initializes both source repositories and reports whether CMake, Ninja, Clang, xz, and PS5_PAYLOAD_SDK are available. It does not download a proprietary SDK or claim that the payload is ready for hardware.

## Create the Codex Cloud environment

Create the environment on ChatGPT web or desktop, select this private repository, and use this install command:

    bash scripts/codex-cloud-setup.sh

Review the setup result and publish the environment. After it is published, open Codex on mobile and select that environment. New environments are created on web or desktop; mobile can start work from a published environment.

## Scope and testing

The checklist records features documented by official etaHEN 2.5B. The community reference contains a 13.42 firmware profile, but its own manifest marks that profile as not hardware-confirmed. No 13.42 payload build or console test is included here yet.

Use the upstream project license and notices in upstream/etaHEN/LICENSE. Keep compatibility changes small, attributed, and reviewable.
