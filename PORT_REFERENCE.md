# Pinned 13.42 source reference

This workbench pins the unofficial etaHEN 2.5B multi-firmware source at commit `89123ffbc9d14a4515c74800b00124595de60348` in `references/etaHEN-13.42-reference`.

## What the reference shows

- `Source Code/include/port_firmware.h` defines exact firmware profiles, including 13.42.
- `Source Code/libhijacker/source/offsets.cpp` resolves profile data from the system software version.
- `Source Code/include/port_toolbox_route.hpp` chooses the legacy `debug_settings_old` route for firmware 11.00 and later.
- The project also changes startup, ShellUI, and runtime code and pins build dependencies. This confirms that adding one version constant or changing the menu URI alone is not a complete port.
- `firmware-profiles.json` records source revisions and labels 13.42 as a profile that is not hardware-confirmed.

## Scope for this workbench

Keep official etaHEN 2.5B as the source and feature baseline. Use the reference to identify the compatibility changes needed for 13.42. Do not adopt its separate Toolbox card, added plugin/FPS features, altered menu assets, or binaries unless the user asks for them.

The overlays adapt the 13.42 libhijacker profile fields used by `offsets.cpp` and the firmware-aware Toolbox route. The route change applies only to existing official entry points; it preserves the upstream URI forms below 11.00 and selects the legacy route on 11.00 and later. Both overlays are applied by the setup script and have host-side regression tests. Startup, kstuff, Settings bundle behavior, and Game Options still need separate work. Keep the changes experimental until a real 13.42 console test is reported.

## Sources

- [Reference release](https://github.com/GronedWaffel/etahen-11.00-13.60/releases/tag/v2.5B-unified.1)
- [Reference firmware profile](https://github.com/GronedWaffel/etahen-11.00-13.60/blob/v2.5B-unified.1/Source%20Code/include/port_firmware.h)
- [Reference route helper](https://github.com/GronedWaffel/etahen-11.00-13.60/blob/v2.5B-unified.1/Source%20Code/include/port_toolbox_route.hpp)
- [Reference profile manifest](https://github.com/GronedWaffel/etahen-11.00-13.60/blob/v2.5B-unified.1/firmware-profiles.json)
