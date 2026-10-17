# etaHEN 2.5B — PS5 13.42 port workbench

This repository is a clean Codex workbench for inspecting the etaHEN 2.5B source and preparing a verified 13.42 compatibility port.

The upstream source is pinned as a Git submodule at etaHEN tag 2.5B, commit 5061a85312eb1d2da811269bcb9061e4b01302a1. The source is under upstream/etaHEN/Source Code.

## What is here

- AGENTS.md: project-specific instructions for Codex
- FEATURES.md: upstream feature checklist for your console testing
- PORT_STATUS.md: what is known and what still needs verification for 13.42
- scripts/codex-cloud-setup.sh: initialize the pinned source and check the build toolchain
- upstream/etaHEN: upstream etaHEN source, pinned to 2.5B

## Prepare the source

Clone with submodules enabled, or run:

    bash scripts/codex-cloud-setup.sh

The script initializes the source submodule and reports whether CMake, Ninja, Clang, xz, and PS5_PAYLOAD_SDK are available. It does not download a proprietary SDK or claim that the payload is ready for hardware.

## Create the Codex Cloud environment

Create the environment on ChatGPT web or desktop, select this private repository, and use this install command:

    bash scripts/codex-cloud-setup.sh

Review the setup result and publish the environment. After it is published, open Codex on mobile and select that environment. New environments are created on web or desktop; mobile can start work from a published environment.

## Scope and testing

The feature list records what etaHEN 2.5B documents. It does not mean every feature has been ported to 13.42 or tested on a console. The port status identifies the missing Settings-bundle evidence. A 13.42 build and a real console test are still required before calling the port working.

Use the upstream project license and notices in upstream/etaHEN/LICENSE. Keep upstream changes in this workbench clearly reviewable.
