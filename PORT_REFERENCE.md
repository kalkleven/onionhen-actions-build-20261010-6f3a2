# Pinned 13.60 r3 source

The source submodule `upstream/etaHEN` points to the tagged release commit:

- Repository: https://github.com/GronedWaffel/etahen-11.00-13.60
- Tag: `v2.5B-13.60-r3`
- Commit: `f59d709228954918e61e8e1b7e64d4b70b24be2f`
- Release ELF SHA-256: `aa166a43347d10a31f7efa5ca26ec32f512c65e8910466bfc8033537337b87b2`

The pinned source already contains the 13.60 runtime and the existing `debug_settings_old` route. In r3, `port_toolbox_root_requested()` accepts only etaHEN-specific card/shortcut URIs, and `patch_bundle_strings()` returns early for 13.60. The main bootstrapper embeds a card installer. The XML also omits the Homebrew Store and PS5 webMAN Games entries even though their handlers remain in the source.

The overlay redirects normal Sony Debug Settings URIs into r3's legacy Toolbox page, restores the bundle branding and menu entries, and embeds the ownership-checked card removal helper in the main payload. It does not alter the 13.60 firmware profile, kstuff or fPKG implementation.
