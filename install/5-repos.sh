#!/bin/bash

set -e

echo "Configuring Chaotic AUR repository..."

echo "Retrieving primary key..."
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com

echo "Locally signing the key..."
sudo pacman-key --lsign-key 3056513887B78AEB

echo "Installing chaotic-keyring and chaotic-mirrorlist..."
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' --noconfirm
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm

echo "Adding chaotic-aur repository to pacman.conf..."
if ! grep -q "\[chaotic-aur\]" /etc/pacman.conf; then
    echo "" | sudo tee -a /etc/pacman.conf
    echo "[chaotic-aur]" | sudo tee -a /etc/pacman.conf
    echo "Include = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
    echo "Repository configuration added to pacman.conf"
else
    echo "Chaotic AUR repository already configured in pacman.conf"
fi

echo "Updating repositories..."
sudo pacman -Syy

echo "Chaotic AUR repository configured successfully!" 