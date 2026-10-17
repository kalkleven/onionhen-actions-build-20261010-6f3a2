# etaHEN 2.5B feature checklist

Check these against the source build you test. Items below are described by the upstream README or the 2.5B changelog; the checklist does not claim 13.42 compatibility.

## Toolbox, menus, and system features

- [ ] etaHEN Toolbox replacing Debug Settings
- [ ] Custom etaHEN plugins
- [ ] Install Homebrew Store from Toolbox
- [ ] Rest Mode options
- [ ] Remote Play menu
- [ ] Plugin and payload ELF menu with auto-start options
- [ ] External HDD menu
- [ ] TestKit menu
- [ ] Kstuff menu
- [ ] Game overlay menu
- [ ] Cheats menu
- [ ] Controller shortcuts
- [ ] PS5 webMAN Games menu
- [ ] Custom Game Options menu
- [ ] Display Title IDs on the Home menu
- [ ] Disable Toolbox auto-start
- [ ] Blu-ray license activation
- [ ] Automatic disc eject for BD-J and LUA-based exploits
- [ ] etaHEN credits and supporters
- [ ] Custom Debug Settings text and icon
- [ ] Auto-open menu after etaHEN loads
- [ ] Toolbox settings

## Runtime and services

- [ ] React bundle FTP decryption support across firmware versions
- [ ] SELF FTP decryption support on 2.xx
- [ ] Two separate daemons for reliability
- [ ] Utility daemon auto-restart by the main daemon
- [ ] Custom system software version in System Information
- [ ] Kstuff support for fSELF and fPKG
- [ ] etaHEN logs under /data/etaHEN
- [ ] Optional system-wide controller shortcut to open Itemzflow
- [ ] Game Dumper integration with Itemzflow
- [ ] HEN configuration file
- [ ] App jailbreak IPC call
- [ ] Update blocker that unmounts the update partition
- [ ] Optional Illusions cheats/patches plugin
- [ ] Optional FTP server on port 1337
- [ ] Optional /data access inside app sandboxes
- [ ] Klog server on port 9081
- [ ] ELF loader on port 9021
- [ ] Optional PS5Debug
- [ ] Itemzflow integration
- [ ] Optional Discord RPC server on port 8000
- [ ] Optional Direct PKG Installer v2 WebUI on port 12800
- [ ] Optional Direct PKG Installer service on port 9090

## etaHEN 2.5B changelog items

- [ ] Choose etaHEN or GoldHEN repository as the cheat update source
- [ ] Option to unpause kstuff when a game closes
- [ ] Fewer notifications with a new notification type and icon
- [ ] Manual fan threshold setting in Toolbox settings
- [ ] Beta Game/App dumper in the Game Options menu
- [ ] WebMAN Games rewrite with M.2 support fixes and other fixes
- [ ] Custom star Delete option for games/apps, patches, and more
- [ ] Experimental PS4 FPS section

## Test notes

For each item, note the console firmware, whether the item appears, whether it opens, and any error or crash. Start with the Settings / Debug Settings Toolbox entry and the Game Options menu. Do not assume a checked source feature works on firmware 13.42 until it has been tested.
