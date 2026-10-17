# etaHEN 2.5B r3 feature preservation

The pinned source is the 13.60 r3 release. The local patch is limited to Debug Settings routing, the old card cleanup helper, and restoring two Toolbox entries that are present in the r3 handlers but absent from its menu XML.

| Feature | Source status |
|---|---|
| etaHEN Toolbox from Debug Settings | Route and label/icon overlay added; console check still needed |
| Homebrew Store | Original handler retained; Toolbox button restored |
| PS5 webMAN Games | Original games-list handler retained; Toolbox link restored |
| Kstuff and PS4 fPKG support | Retained from the pinned r3 payload sources |
| Existing separate Toolbox home-screen card | The main payload now starts the r3 ownership-checked removal helper instead of installing the card |

Use the console and firmware version in test notes. A feature being present in the r3 source does not establish that this local patched ELF has been built or tested.
