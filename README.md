# Omarchy - Ivans Custom Fork Edition

This is a custom fork of [Omarchy](https://github.com/basecamp/omarchy) by [DHH](https://github.com/dhh)

- Added Chaotic AUR repository.
- Removed CUPS (printer), Signal, Spotify, Dropbox, Zoom and webapps.
- Replaced 1Password with KeepassXC.
- Replaced VLC with MPV.
- Replaced Chromium with ungoogled-chromium.
- Added Virtio and VM support (SPICE).
- Bluetooth disabled by default. Run `sudo systemctl enable --now bluetooth.service` to enable it.
- Added FIDO2 support.
- Added FUSE2 support (some AppImages depend on it).
- Rank mirrors first using reflector for fast package download speeds.

## WIP

- [ ] CI Tests via Docker. 

## Installation

```bash
curl -s https://raw.githubusercontent.com/Sudo-Ivan/omarchy/refs/heads/master/boot.sh | bash
```

## License

[MIT License](https://opensource.org/licenses/MIT)

