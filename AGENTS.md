# Project instructions

## Goal

Use etaHEN 2.5B 13.60 r3 as the pinned source baseline. Apply the small local overlay so the existing Debug Settings entry opens etaHEN Toolbox and the old separate home-screen card is removed.

## Source baseline

- The source submodule `upstream/etaHEN` is pinned to GronedWaffel/etahen-11.00-13.60 commit `f59d709228954918e61e8e1b7e64d4b70b24be2f`, tag `v2.5B-13.60-r3`.
- The original release ELF is 30,410,624 bytes with SHA-256 `aa166a43347d10a31f7efa5ca26ec32f512c65e8910466bfc8033537337b87b2`.
- Keep the upstream 13.60 runtime, kstuff and fPKG support intact. The local patch restores the Homebrew Store and PS5 webMAN Games Toolbox entries.
- Do not include the upstream installer behavior in the built main ELF. The embedded cleanup helper may remove only the old `ETHN13600` etaHEN-owned card after its ownership marker matches.

## Compatibility and verification

- The 13.60 route overlay redirects both standard Sony Debug Settings URIs to etaHEN's existing `debug_settings_old` Toolbox route, while retaining the legacy card/shortcut route.
- Re-enable the bundle label/icon replacement so the Debug Settings entry can be branded as etaHEN Toolbox.
- Run `bash scripts/codex-cloud-setup.sh` after submodule initialization. Run `bash scripts/test_1360_route.sh` and `bash scripts/test_1360_overlay.sh` after changing the overlay.
- Follow `upstream/etaHEN/BUILDING.md` for the PS5 SDK and external build inputs.
- Record whether the patched ELF was built and tested on a console. Never describe the local overlay as hardware-validated unless that test has actually happened.

## Licensing

Keep upstream copyright and GPL notices intact. Keep the local compatibility change in `patches/13.60/debug-settings.patch` and document its source behavior.
