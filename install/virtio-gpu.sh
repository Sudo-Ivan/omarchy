yay -S --noconfirm --needed \
  xf86-video-qxl spice-vdagent

sudo systemctl enable --now spice-vdagentd

if ! grep -q "virtio_gpu" /etc/mkinitcpio.conf; then
  sudo sed -i '/^MODULES=/ s/)/ virtio_gpu virtio_pci virtio_blk virtio_scsi virtio_net)/' /etc/mkinitcpio.conf
  sudo mkinitcpio -P
fi