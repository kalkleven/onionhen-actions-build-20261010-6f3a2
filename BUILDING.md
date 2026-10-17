# Build the patched 13.60 payload

1. Initialize and patch the pinned r3 source:

       bash scripts/codex-cloud-setup.sh

2. Install the exact compiler, PS5 Payload SDK, external libraries and prebuilt release assets described by [the pinned source build guide](upstream/etaHEN/BUILDING.md). That guide records the supported Node.js 24, Zig 0.14.1 and PS5 Payload SDK v0.43 toolchain.

3. Run the upstream build commands from the submodule:

       cd upstream/etaHEN
       node scripts/check-build-inputs.mjs
       node scripts/build-all.mjs

The output is `build/etaHEN-13.60-debug-settings.elf` inside the submodule, with its hash recorded in `build/manifest.json`.

The original r3 release ELF is not the patched build. This workspace did not have the SDK inputs required to compile or hardware-test the overlay.
