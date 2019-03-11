#!/bin/bash

## Install packages

PKGS="git curl vim tofrodos rxvt-unicode-256color"

if dpkg -l | grep -q xserver; then
    # grapical display
    PKGS="$PKGS gitk emacs"
else
    # Non graphical display
    PKGS="$PKGS emacs-nox"
fi

sudo apt install -y $PKGS

# One cannot source this file
RC_FOLDER=$(dirname $(readlink -f $0))

function install_link {
    local DEST=$1
    shift
    for f in $@; do
        if [ -e $DEST/.$f ]; then
            [ -L $DEST/.$f ] && rm -f $DEST/.$f || mv -f $DEST/.$f $DEST/.$f.orig
        fi
        ln -sv $RC_FOLDER/$f $DEST/.$f
    done;
}

## Install rc files from this directory to the current user
RC_FILES="bashrc bash_aliases gitconfig Xresources"
CONFIG_FILES="$(ls -d config/*)"
install_link $HOME $RC_FILES $CONFIG_FILES

## Emacs config
if test -e ~/.emacs.d && test ! -d ~/.emacs.d; then
    rm -f ~/.emacs.d
fi
[ -e ~/.emacs ] && mv ~/.emacs ~/.emacs.orig

if [ -d ~/.emacs.d ]; then
    echo "~/.emacs.d already exists, keep it."
else
    pushd ~/
    git clone --recurse-submodules https://github.com/burton-aad/.emacs.d.git
    popd
fi

## URxvt
# get extensions
mkdir -p ~/.urxvt/ext
pushd ~/.urxvt/ext > /dev/null
curl --remote-name-all https://raw.githubusercontent.com/pkkolos/urxvt-scripts/master/vtwheel \
                       https://raw.githubusercontent.com/burton-aad/urxvt-softclear/master/soft-clear
popd > /dev/null
