sudo pacman -S --needed --noconfirm reflector

sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
sudo reflector --country US,DE,NL --age 6 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
echo testing mirrors...
sudo pacman -Sy