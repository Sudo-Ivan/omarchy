yay -S --noconfirm --needed \
  wget curl unzip inetutils \
  fd eza fzf ripgrep zoxide bat \
  wl-clipboard fastfetch btop \
  man tldr less whois $(if ! command -v updatedb &> /dev/null; then echo "plocate"; fi) \
  alacritty
