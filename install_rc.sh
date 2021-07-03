#!/bin/bash

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


## Emacs config
# clone configs
[ -d config/emacs.d ] || git clone --recurse-submodules https://github.com/burton-aad/emacs.d.git config/emacs.d
if [ ! -d config/doom-emacs ]; then
  git clone --depth 1 https://github.com/hlissner/doom-emacs config/doom-emacs
  ./config/doom-emacs/bin/doom install
fi
if [ ! -d config/spacemacs ]; then
  git clone https://github.com/syl20bnr/spacemacs config/spacemacs
fi

# Move old emacs configs
if test -e ~/.emacs.d && test ! -d ~/.emacs.d; then
    rm -f ~/.emacs.d
fi
[ -e ~/.emacs ] && mv ~/.emacs ~/.emacs.orig

if [ -d ~/.emacs.d ]; then
    echo "~/.emacs.d already exists, keep it."
else
    git clone https://github.com/plexus/chemacs2.git ~/.emacs.d
fi


## Install rc files from this directory to the current user
RC_FILES="bashrc bash_aliases gitconfig Xresources tmux.conf"
CONFIG_FILES="$(ls -d config/*)"
install_link $HOME $RC_FILES $CONFIG_FILES


## URxvt
# get extensions
mkdir -p ~/.urxvt/ext
pushd ~/.urxvt/ext > /dev/null
curl --remote-name-all https://raw.githubusercontent.com/pkkolos/urxvt-scripts/master/vtwheel \
                       https://raw.githubusercontent.com/burton-aad/urxvt-softclear/master/soft-clear
popd > /dev/null
