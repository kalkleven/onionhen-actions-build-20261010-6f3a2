# etaHEN 2.5B r3 — 13.60 Debug Settings route

This repository pins the source for the etaHEN 2.5B 13.60 r3 release and applies a small source overlay so the normal Debug Settings entry opens etaHEN Toolbox.

## Pinned release

- Source tag: [v2.5B-13.60-r3](https://github.com/GronedWaffel/etahen-11.00-13.60/tree/v2.5B-13.60-r3)
- Source commit: `f59d709228954918e61e8e1b7e64d4b70b24be2f`
- Original ELF: [etaHEN-13.60.elf](https://github.com/GronedWaffel/etahen-11.00-13.60/releases/download/v2.5B-13.60-r3/etaHEN-13.60.elf)
- Original ELF SHA-256: `aa166a43347d10a31f7efa5ca26ec32f512c65e8910466bfc8033537337b87b2`

The full source is available through the pinned submodule at `upstream/etaHEN`. This repository does not contain a copied ELF asset; the connected GitHub file tools can write text but cannot transfer release binaries. The patch must be built into a new ELF before it changes console behavior.

## Local overlay

`patches/13.60/debug-settings.patch` makes these source changes:

- Routes the regular Sony `debug_settings` entry to r3's working legacy Toolbox page.
- Re-enables etaHEN's Debug Settings label and icon replacement.
- Restores the Homebrew Store and PS5 webMAN Games entries. Their handlers remain in the pinned source.
- Embeds the existing ownership-checked card removal helper in the main payload instead of the card installer.
- Names the generated payload `etaHEN-13.60-debug-settings.elf`.

The payload retains the pinned r3 sources, including the existing kstuff and PS4 fPKG path.

## Prepare and build

Run the source overlay checks:

    bash scripts/codex-cloud-setup.sh

The PS5 target build needs the compiler, PS5 Payload SDK, external libraries and release assets listed in `upstream/etaHEN/BUILDING.md`. Once those inputs are installed, build from the source submodule:

    cd upstream/etaHEN
    node scripts/check-build-inputs.mjs
    node scripts/build-all.mjs

The expected output is `upstream/etaHEN/build/etaHEN-13.60-debug-settings.elf`. The connected workspace did not have the target SDK or build inputs, so this ELF has not been produced here. The route has host-side regression coverage; the final settings page and cleanup need a console test.
