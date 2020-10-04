#!/bin/bash

set -e

# Some links
[ ! -f "$HOME/.common-shell.sh" ] && ln -s "$PWD/.common-shell.sh" "$HOME/.common-shell.sh"
[ ! -f "$HOME/.yabairc" ] && ln -s "$PWD/.yabairc" "$HOME/.yabairc"
[ ! -f "$HOME/.skhdrc" ] && ln -s "$PWD/.skhdrc" "$HOME/.skhdrc"
[ ! -f "$HOME/.tmux.conf" ] && ln -s "$PWD/.tmux.conf" "$HOME/.tmux.conf"

# Making sure stuff gets loaded
LINE="source $HOME/.common-shell.sh"
FILE="$HOME/.zshrc"
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
FILE="$HOME/.bashrc"
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"

# Vim setups
[ ! -f "$HOME/.ideavimrc" ] && ln -s "$PWD/.ideavimrc" "$HOME/.ideavimrc"
mkdir -p $HOME/.config/
[ ! -d "$HOME/.config/nvim" ] && ln -s "$PWD/nvim" "$HOME/.config/nvim"

mkdir -p $HOME/.config/coc/extensions/
[ ! -f "$HOME/.config/coc/extensions/package.json" ] && ln -s "$PWD/coc/extensions/package.json" "$HOME/.config/coc/extensions/package.json"
pushd $HOME/.config/coc/extensions/
npm install
popd


