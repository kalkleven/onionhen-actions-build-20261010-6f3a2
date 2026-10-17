# 13.42 port status

## Menu visibility

The pinned etaHEN 2.5B README lists the etaHEN Toolbox as a Debug Settings replacement and describes a Custom Game Options Menu. The 2.5B changelog also lists a beta Game/App dumper in the Game options menu. This answers where the upstream project intends the UI to appear; it does not verify 13.42 behavior.

## Findings from the older private workspace

Before this workbench reset, the older private OnionHEN fork had low-level 13.42 version entries in its libhijacker offset map. Its ShellUI Debug Settings policy did not have a verified 13.42 Settings-bundle fingerprint; the inspected profile list ended at 12.70.

The prior main-branch head was 19ce374aeb808a6ccd61db6522a9cdb10ff60cb4. Git history still contains that tree for recovery and comparison. The old source was not copied into this clean upstream baseline.

## Required before claiming 13.42 support

- [ ] Inspect the pinned 2.5B code paths that create the Debug Settings / Toolbox entry and game options entry.
- [ ] Obtain and verify the 13.42 Settings bundle fingerprint and route behavior from a legitimate 13.42 test environment.
- [ ] Add only evidence-backed compatibility data and tests.
- [ ] Run the relevant source tests and build with the PS5 Payload SDK.
- [ ] Ask the user to test the build on their own console and record the result.

Current status: the repository is a source workbench and feature checklist. No 13.42 payload build or console test is included.
