# etaHEN 13.60 overlay status

## Baseline

The workbench now pins the etaHEN 2.5B 13.60 r3 source at commit `f59d709228954918e61e8e1b7e64d4b70b24be2f`. The upstream release ELF is 30,410,624 bytes and has SHA-256 `aa166a43347d10a31f7efa5ca26ec32f512c65e8910466bfc8033537337b87b2`.

## Changes in the overlay

- Standard `debug_settings` URIs now redirect to the existing r3 `debug_settings_old` Toolbox page.
- The ShellUI bundle text/icon replacement is enabled for 13.60.
- The Homebrew Store button and PS5 webMAN Games link are restored; the pinned source handlers remain intact.
- The main ELF embeds the r3 ownership-checked card removal helper instead of starting the installer.
- The build output is named `etaHEN-13.60-debug-settings.elf`.

## Verification

- The patch applies cleanly to the pinned r3 source files.
- The host route regression test passes for standard and legacy URIs, and rejects unrelated routes.
- The source overlay checks verify the restored Toolbox IDs, handler presence, card cleanup wiring, and retained fPKG hook.
- No patched target ELF or PS5 console test was produced in this workspace because the PS5 SDK and external build inputs are not available here. The published r3 binary remains the unmodified upstream asset.

See `BUILDING.md` for the target build steps and `FEATURES.md` for preservation notes.
