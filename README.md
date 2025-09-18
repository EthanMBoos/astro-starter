# New VM Dependencies & Terminal Setup

```shell
# Clear out old settings (if present)
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```
### Dependencies & Terminal
```bash
# Install dependencies
sudo apt update
sudo apt upgrade

# Dev packages
sudo apt install net-tools
sudo apt install xclip

# Nvim dependencies
sudo apt install ripgrep
sudo snap install nvim --classic
sudo apt install clangd
sudo apt install vim
sudo apt install curl

# Git setup
sudo apt install git
git config --user.name "<name>"
git config --user.email "<email>"
git config --global core.editor “nvim”
ssh-keygen -t rsa -b 4096
ssh-add ~./ssh/id_rsa

# Lazygit - https://github.com/jesseduffield/lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/

# Download Hackfont - https://www.nerdfonts.com/font-downloads
cd ~/Downloads
sudo unzip Hack.zip -d /usr/local/share/fonts
# Go to terminal preferences and select Hackfont mono
sudo fc-cache -f -v
# Close terminal, open another

# Terminal Catpuccin theme
# https://github.com/catppuccin/gnome-terminal
curl -L https://raw.githubusercontent.com/catppuccin/gnome-terminal/v1.0.0/install.py | python3 -
# Go go terminal preferences, set as default
# Close terminal, open another

# Put terminal in vim mode.
# Add the below line to ~/.bashrc
set -o vi
```

### Tmux 
```bash
# Install tmux and plugin manager
sudo apt install tmux
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

#### Source tmux and download neovim config
```bash
tmux

# One time needed
# ---------------------------
tmux source-file ~/.tmux.conf
# In terminal: ctrl + s + I
git clone https://github.com/EthanMBoos/astro-starter ~/.config/nvim
# ---------------------------

nvim
```
---
#### VirtualBox Guest Additions
Install dependencies
```bash
sudo apt install build-essential dkms
```

With vm closed go to vbox vm Settings > Display > Enable 3D Acceleration

Insert guest additions cd image.

Double click on cd in banner. Open in terminal.
```bash
sudo ./VBoxLinuxAdditions.run
```
Restart vm.

Enable autoresize and bidirectional keyboard.

---
#### Configure clangd lsp for any docker project
Install clangd in the container. Either add the dependency to the dockerfile on container build or install by cli,
```clangd
sudo apt update
sudo apt install clangd
```
Generate a `compile_commands.json` file. Add the following line to your top-level `CMakeLists.txt` file and re-run CMake.
```bash
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
```

Configure `astrolsp.lua` to match the docker environment,
```bash
clangd = { "docker", "exec", "-it", "<container_name>", "clangd", "--background-index", "--path-mappings=/home/<host_usr>/code=/home/<docker_usr>", "--compile-commands-dir=./build"},
```
Verify the setup. Run `:LspInfo` in Neovim to confirm that the clangd client is attached and running. If not installed, run `:Mason` and click i on clangd.
