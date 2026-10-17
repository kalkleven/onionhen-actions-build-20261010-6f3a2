# 13.42 port status

## Menu locations

Official etaHEN 2.5B documents the etaHEN Toolbox as replacing Debug Settings and provides a custom Game Options menu, including a beta Game/App dumper entry. The community multi-firmware reference uses the legacy Debug Settings route for 11.00 and later and also has a separate home-screen Toolbox card. Preserve the official 2.5B menu behavior as the target.

## Applied compatibility slice

The tracked overlay at `patches/13.42/offsets.patch` adds a 13.42 profile to the official source's `libhijacker` offset lookups for allproc, security flags, QA flags, user-token flags, and root vnode. Values were adapted from the pinned community source reference and are identified in the patch header.

`scripts/codex-cloud-setup.sh` applies all three overlays to the pinned etaHEN submodule. The host-side test `scripts/test_1342_offsets.sh` compiles the actual patched `offsets.cpp` against a stubbed firmware-version query. It passed for 13.42 and confirmed 13.43 remains unsupported.

The overlay at `patches/13.42/toolbox-route.patch` adapts all five upstream Toolbox entry routes in `HookFunctions.cpp`. It selects the legacy `debug_settings_old` URI for firmware 11.00 and newer and preserves the two original URI forms below 11.00. `scripts/test_1342_route.sh` passed for 13.42, 13.60, the 11.00 boundary, and both pre-11.00 URI forms.

The overlay at `patches/13.42/selfpager.patch` adds the 13.42 pager-table offset used by the existing Game/App dumper. The value comes from the pinned reference firmware profile. `scripts/test_1342_selfpager.sh` passed for 13.42 and rejects adjacent unsupported profiles.

These remain partial compatibility layers. Startup, kstuff, Settings bundle behavior, and the per-game Game Options path are not yet adapted. No PS5 target build or console test has been performed. The reference manifest itself marks its 13.42 profile as not hardware-confirmed.

## Compatibility reference

A code-only reference is pinned at `references/etaHEN-13.42-reference`:
- Repository: https://github.com/GronedWaffel/etahen-11.00-13.60
- Release tag: `v2.5B-unified.1`
- Commit: `89123ffbc9d14a4515c74800b00124595de60348`

Its firmware profile table includes 13.42, and its route helper selects the legacy `debug_settings_old` URI for versions 11.00 and later. Its own `firmware-profiles.json` marks 13.42 as `supported-profile-not-hardware-confirmed`. The source has broader startup, runtime, and ABI changes too; a profile row alone is not a complete payload port.

This reference is for source comparison. Its extra/changed features and binaries have not been adopted into this repository.

## Findings from the older private workspace

Before this workbench reset, the older private OnionHEN fork had some low-level 13.42 version entries. Its ShellUI route policy had no verified 13.42 Settings-bundle fingerprint; the inspected profile list ended at 12.70. Those entries cover only part of etaHEN's compatibility needs.

The prior main-branch head was 19ce374aeb808a6ccd61db6522a9cdb10ff60cb4. Git history still contains that tree for recovery and comparison.

## Remaining work

- [x] Pin official etaHEN 2.5B and a 13.42 source reference.
- [x] Add and host-test the reference-derived 13.42 libhijacker profile overlay.
- [ ] Compare and adapt required startup, kstuff, ShellUI, and dependency changes while preserving official features.
- [x] Adapt and host-test the Toolbox route selection across all official Toolbox entry points.
- [ ] Port and test the per-game Game Options path on source.
- [ ] Build with the PS5 Payload SDK and record the build output.
- [ ] Test Toolbox and per-game options on a real 13.42 console and record the result.

Current status: the offset, Toolbox route, and Game/App dumper pager-table overlays are in the repository, and all three host checks pass. There is not yet a complete 13.42 payload, and no PS5 build or hardware test is included.
