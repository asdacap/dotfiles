#!/bin/bash

set -e

[ ! -f "$HOME/.common-shell.sh" ] && ln -s "$PWD/.common-shell.sh" "$HOME/.common-shell.sh"

LINE="source $HOME/.common-shell.sh"
FILE="$HOME/.zshrc"
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
FILE="$HOME/.bashrc"
grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"

[ ! -f "$HOME/.ideavimrc" ] && ln -s "$PWD/.ideavimrc" "$HOME/.ideavimrc"

# Vim setups
mkdir -p $HOME/.config/
[ ! -d "$HOME/.config/nvim" ] && ln -s "$PWD/nvim" "$HOME/.config/nvim"

mkdir -p $HOME/.config/coc/extensions/
[ ! -f "$HOME/.config/coc/extensions/package.json" ] && ln -s "$PWD/coc/extensions/package.json" "$HOME/.config/coc/extensions/package.json"
pushd $HOME/.config/coc/extensions/
npm install
popd
