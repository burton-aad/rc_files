#! /bin/bash

############# HISTORY

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# Unlimited bash history
if [[ ${BASH_VERSINFO[0]} -gt 4 || ( ${BASH_VERSINFO[0]} -eq 4 && ${BASH_VERSINFO[1]} -ge 3 ) ]]; then
  # New in bash 4.3
  export HISTSIZE=-1
  export HISTFILESIZE=-1
else
  # Undocumented feature
  export HISTSIZE=
  export HISTFILESIZE=
fi
# Change file location to avoid issue with some bash session without rc load
export HISTFILE=~/.bash_shared_history


# In case of no HISTSIZE, set it in gdb to get history.
if [ -z "$HISTSIZE" ]; then
  #alias gdb="HISTSIZE=1000000 gdb"
  gdb() { HISTSIZE=70000000; /usr/bin/gdb "$@"; }
  export -f gdb
fi
