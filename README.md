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
# Close terminal, open another

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
unbind r
bind r source-file ~/.tmux.conf

set -g prefix C-s
set -g status off
set -g mouse on

# Navigate with vim keys
# Hold Ctrl + hjkl
setw -g mode-keys vi
bind-key -n -r C-h select-pane -L
bind-key -n -r C-j select-pane -D
bind-key -n -r C-k select-pane -U
bind-key -n -r C-l select-pane -R

# Resize panes with vim keys
# Ctrl + s + hjkl
bind -r h resize-pane -L 5
bind -r j resize-pane -D 5
bind -r k resize-pane -U 5
bind -r l resize-pane -R 5

# Show colors in terminal 
set -g default-terminal "screen-256color"
# Fix mismatched terminal + nvim colors
set-option -sa terminal-features ',xterm-256color:RGB'

# Copy directly to system keyboard
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

# Reduce escape-time for faster vim responsiveness
set-option -s escape-time 0

# Increase scrollback history
set -g history-limit 50000

# List of plugins
#####################################################
# Plugin manager
set -g @plugin 'tmux-plugins/tpm'

# Navigate between tmux and vim with same keybindings
set -g @plugin 'christoomey/vim-tmux-navigator'
#####################################################

# Initialize TMUX plugin manager (keep this line at the bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
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

Insert guest additions cd image.

Double click on cd in banner. Open in terminal.
```bash
sudo ./VBoxLinuxAdditions.run
```
Restart vm.

Enable autoresize and bidirectional keyboard.
