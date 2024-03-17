#!/bin/bash

set -e

# For yabai window shortcut
mkdir -p ~/.config/shortcut_windows/

# Some links
[ ! -f "$HOME/.yabairc" ] && ln -s "$PWD/.yabairc" "$HOME/.yabairc"
[ ! -f "$HOME/.skhdrc" ] && ln -s "$PWD/.skhdrc" "$HOME/.skhdrc"
[ ! -f "$HOME/.tmux.conf" ] && ln -s "$PWD/.tmux.conf" "$HOME/.tmux.conf"
[ ! -f "$HOME/.emacs" ] && ln -s "$PWD/.emacs" "$HOME/.emacs"
[ ! -f "$HOME/.vimrc" ] && ln -s "$PWD/.vimrc" "$HOME/.vimrc"

# Vim setups
[ ! -f "$HOME/.ideavimrc" ] && ln -s "$PWD/.ideavimrc" "$HOME/.ideavimrc"
mkdir -p $HOME/.config/

[ ! -d "$HOME/.config/nvim" ] && ln -s "$PWD/nvim" "$HOME/.config/nvim"

mkdir -p $HOME/.config/home-manager/
[ ! -d "$HOME/.config/home-manager/home.nix" ] && ln -s "$PWD/home.nix" "$HOME/.config/home-manager/home.nix"

