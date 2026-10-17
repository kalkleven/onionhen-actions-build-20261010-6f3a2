# 13.42 port status

## Menu locations

Official etaHEN 2.5B documents the etaHEN Toolbox as replacing Debug Settings and provides a custom Game Options menu, including a beta Game/App dumper entry. The community multi-firmware reference uses the legacy Debug Settings route for 11.00 and later and also has a separate home-screen Toolbox card. Preserve the official 2.5B menu behavior as the target.

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
- [ ] Compare the reference's startup, kernel-profile, ShellUI, and dependency changes against official 2.5B.
- [ ] Implement only the required 13.42 compatibility changes while preserving the official 2.5B feature set.
- [ ] Add source tests for exact firmware selection and menu routing.
- [ ] Build with the PS5 Payload SDK and record the build output.
- [ ] Test Toolbox and per-game options on a real 13.42 console and record the result.

Current status: the repository now has both source baselines for review. No compatibility code has yet been applied to the official source, and no 13.42 payload build or console test is included.
