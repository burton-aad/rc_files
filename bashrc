#! /bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# Emacs run dumb terminal with tramp. Simplify init for tramp
[ $TERM == "dumb" ] && PS1="$ " && return

# Source all files in the ~/.bashrc.d directory
BASHRC_DIR=$HOME/.bashrc.d
for f in $(ls $BASHRC_DIR); do
  source ${BASHRC_DIR}/$f
done
