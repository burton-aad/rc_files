#!/bin/bash

# One cannot source this file
RC_FOLDER=$(dirname $(readlink -f $0))

function perr {
  echo -e "\033[1;91m[ERR] $@\033[0m"
}

function install_link {
    local DEST=$1
    shift
    for f in $@; do
        if [ -e $DEST/.$f ]; then
            [ -L $DEST/.$f ] && rm -f $DEST/.$f || mv -f $DEST/.$f $DEST/.$f.orig
        fi
        mkdir -p $(dirname $DEST/.$f)
        ln -sv $RC_FOLDER/$f $DEST/.$f
    done;
}

# Install rc files
RC_FILES="bashrc $(ls bashrc.d/*) gitconfig Xresources tmux.conf doom.d vimrc"
install_link $HOME $RC_FILES

## Install config files after filling it with all repos
CONFIG_FILES="$(ls -d config/*)"
install_link $HOME $CONFIG_FILES


## Emacs config
# clone configs
[ -d config/emacs.d ] || git clone --recurse-submodules https://github.com/burton-aad/emacs.d.git config/emacs.d
if [ ! -d config/doom-emacs ]; then
  git clone --depth 1 https://github.com/hlissner/doom-emacs config/doom-emacs
  # ./config/doom-emacs/bin/doom install
  ./config/doom-emacs/bin/doom sync
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
    perr "~/.emacs.d already exists, keep it."
else
    git clone https://github.com/plexus/chemacs2.git ~/.emacs.d
fi


## URxvt
# get extensions
mkdir -p ~/.urxvt/ext
pushd ~/.urxvt/ext > /dev/null
curl --remote-name-all https://raw.githubusercontent.com/pkkolos/urxvt-scripts/master/vtwheel \
                       https://raw.githubusercontent.com/burton-aad/urxvt-softclear/master/soft-clear
popd > /dev/null


## Kitty
# get extensions
pushd $RC_FOLDER/config/kitty > /dev/null
curl --remote-name-all https://raw.githubusercontent.com/burton-aad/kitty-xmap/master/xmap.py
popd > /dev/null
