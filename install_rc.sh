#!/bin/bash

## Install packages

PKGS="git curl vim"

if dpkg -l | grep -q xserver; then
    # grapical display
    PKGS="$PKGS gitk emacs"
else
    # Non graphical display
    PKGS="$PKGS emacs-nox"
fi

sudo apt install -y $PKGS

## Install rc files from this directory to the current user

RC_FILES="bashrc bash_aliases"

for f in $RC_FILES; do
    [ -f ~/.$f ] && rm -f ~/.$f
    ln -s $f ~/.$f
done;

## Emacs config
pushd ~/
git clone --recurse-submodules https://github.com/burton-aad/.emacs.d.git
popd
