sudo pacman -S --needed --noconfirm reflector

sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
sudo reflector --country US,CA,GB,DE,FR,NL,SE,NO,DK,FI --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Sy