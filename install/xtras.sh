if [ -z "$OMARCHY_BARE" ]; then
  yay -S --noconfirm --needed \
    gnome-calculator \
    obsidian-bin onlyoffice-bin gnome-keyring \
    strawberry fuse2 libfido2 flatpak
fi

# Copy over Omarchy applications
source ~/.local/share/omarchy/bin/omarchy-sync-applications || true
