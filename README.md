# New VM Dependencies & Terminal Setup

```shell
# Clear out old settings (if present)
rm ~/.config/nvim
rm ~/.local/share/nvim
rm ~/.local/state/nvim
rm ~/.cache/nvim
```
### Dependencies & Terminal
```bash
# Install dependencies
sudo apt-get update
sudo apt-get upgrade

# Dev packages
sudo apt-get install net-tools
sudo apt-get install xclip
sudo snap install lnav

# Nvim dependencies
sudo apt-get install ripgrep
sudo snap install nvim --classic
sudo apt-get install clangd
sudo apt-get install vim

# Git setup
sudo apt-get install git
git config --user.name "<name>"
git config --user.email "<email>"
git config —global core.editor “nvim”
ssh-keygen -t rsa -b 4096
ssh-add ~./ssh/id_rsa

# Lazygit - https://github.com/jesseduffield/lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/

# Download Hackfont - https://www.nerdfonts.com/font-downloads
sudo mkdir /usr/local/share/fonts/
cd ~/Downloads
sudo unzip Hack.zip -d /usr/local/share/fonts
sudo fc-cache -f -v
# Go to terminal preferences and select Hackfont

# Terminal Catpuccin theme
# https://github.com/catppuccin/gnome-terminal
curl -L https://raw.githubusercontent.com/catppuccin/gnome-terminal/v1.0.0/install.py | python3 -
# Go go gnome terminal and select profile

# Put terminal in vim mode.
# Add the below line to ~/.bashrc
set -o vi
```

### Tmux 
```bash
# Install tmux and plugin manager
sudo apt-get install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 

# Create config file
vim ~/.tmux.conf
```

#### Tmux config file settings
```bash

```

#### Source tmux and run neovim
```bash
# Before running tmux command source the new config
tmux source-file ~/.tmux.conf
tmux
nvim
```
---
##### VirtualBox Guest Additions Aside
With vm closed go to vbox vm Settings > Display > Enable 3D Acceleration

Insert guest additions cd image
Double click on cd in banner. Open in terminal.
```bash
sudo ./VBoxLinuxAdditions.run
```
restart vm
Enable autoresize and bidirectional keyboard.
