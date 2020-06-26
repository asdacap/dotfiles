#!/bin/bash

set -e

mkdir -p $HOME/.config/
[ ! -d "$HOME/.config/nvim" ] && ln -s "$PWD/nvim" "$HOME/.config/nvim"

mkdir -p $HOME/.config/coc/extensions/
[ ! -f "$HOME/.config/coc/extensions/package.json" ] && ln -s "$PWD/coc/extensions/package.json" "$HOME/.config/coc/extensions/package.json"
pushd $HOME/.config/coc/extensions/
npm install
popd

[ ! -f "$HOME/.ideavimrc" ] && ln -s "$PWD/.ideavimrc" "$HOME/.ideavimrc"
