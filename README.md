# Omarchy - Ivans Custom Fork Edition

This is a based fork of [Omarchy](https://github.com/basecamp/omarchy) by [DHH](https://github.com/dhh)

- Added Chaotic AUR repository and enabled multilib.
- Removed CUPS (printer), Signal, Spotify, Dropbox, Zoom and webapps.
- Replaced 1Password with KeepassXC.
- Replaced VLC with MPV.
- Replaced Chromium with ungoogled-chromium.
- Bluetooth disabled by default. Run `sudo systemctl enable --now bluetooth.service` to enable it.
- Added FIDO2 support.
- Added FUSE2 support (some AppImages depend on it).
- Rank mirrors first using reflector for fast package download speeds.
- Added Flatpak.
- Install and enable OpenSnitch firewall.
- Test using Docker or Github Actions
- Remove docker from base installation and to bin/ivans-dev-setup

## Optional Configuration Scripts

- `bin/ivans-custom-setup` - My custom post-setup script. 
- `bin/time-sync` - Time synchronization script using HTTPS to trusted sources.

### Ivans Custom Setup

- Replace `sudo` with `doas`.
- Install, enable and setup Wazuh agent.
- Install auditd, yara and lynis.
- Slight kernel hardening.
- Use HTTPS for time synchronization and disable NTP.
- Spoof machine-id.
- Install flatpaks 
- Set Search Engine to Quad4 SearXNG for ungoogled-chromium (via organization policy)
- Install virt-manager and qemu-full
- Install and enable Tailscale.

## WIP

- [ ] Runit support (Artix)
- [ ] Xlibre

## Installation

```bash
curl -s https://raw.githubusercontent.com/Sudo-Ivan/omarchy/refs/heads/master/boot.sh | bash
```

## License

[MIT License](https://opensource.org/licenses/MIT)

