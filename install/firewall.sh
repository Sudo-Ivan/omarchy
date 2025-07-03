#!/bin/bash

echo "Installing OpenSnitch application firewall..."

yay -S --noconfirm --needed opensnitch
sudo systemctl enable --now opensnitchd.service

echo "OpenSnitch installed and enabled" 