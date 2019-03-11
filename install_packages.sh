#!/bin/bash

## Install packages

PKGS="git curl vim tofrodos rxvt-unicode-256color libterm-readkey-perl"

if dpkg -l | grep -q xserver; then
    # grapical display
    PKGS="$PKGS gitk emacs"
else
    # Non graphical display
    PKGS="$PKGS emacs-nox"
fi

sudo apt install -y $PKGS
