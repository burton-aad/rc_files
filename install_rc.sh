#!/bin/bash

## Install packages

PKGS="git curl vim tofrodos"

if dpkg -l | grep -q xserver; then
    # grapical display
    PKGS="$PKGS gitk emacs"
else
    # Non graphical display
    PKGS="$PKGS emacs-nox"
fi

sudo apt install -y $PKGS

## Install rc files from this directory to the current user

RC_FILES="bashrc bash_aliases gitconfig"

for f in $RC_FILES; do
    [ -e ~/.$f -o -L ~/.$f ] && rm -f ~/.$f
    ln -s $(dirname $(readlink -f $0))/$f ~/.$f
done;

## Emacs config
if test -e ~/.emacs.d && test ! -d ~/.emacs.d; then
    rm -f ~/.emacs.d
fi

if [ -d ~/.emacs.d ]; then
    echo "~/.emacs.d already exists, keep it."
else
    pushd ~/
    git clone --recurse-submodules https://github.com/burton-aad/.emacs.d.git
    popd
fi
