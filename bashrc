#! /bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

LOCAL_PWD=$(dirname $(readlink -f ${BASH_SOURCE[0]}))



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


############# Shell options

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    # see man 4 console_codes
    # \[ and \] are used in bash prompt (see man bash PROMPTING) to start and
    # end a sequence character so size of prompt is correctly computed.
    export COLOR_BLACK="\[\033[0;30m\]"
    export COLOR_DARKGRAY="\[\033[1;30m\]"
    export COLOR_RED="\[\033[0;31m\]"
    export COLOR_LIGHT_RED="\[\033[1;31m\]"
    export COLOR_GREEN="\[\033[0;32m\]"
    export COLOR_LIGHT_GREEN="\[\033[1;32m\]"
    export COLOR_BROWN="\[\033[0;33m\]"
    export COLOR_YELLOW="\[\033[1;33m\]"
    export COLOR_BLUE="\[\033[0;34m\]"
    export COLOR_LIGHT_BLUE="\[\033[1;34m\]"
    export COLOR_PURPLE="\[\033[0;35m\]"
    export COLOR_LIGHT_PURPLE="\[\033[1;35m\]"
    export COLOR_CYAN="\[\033[0;36m\]"
    export COLOR_LIGHT_CYAN="\[\033[1;36m\]"
    export COLOR_GRAY="\[\033[0;37m\]"
    export COLOR_WHITE="\[\033[1;37m\]"
    export COLOR_NEUTRAL="\[\033[0m\]"
  else
    color_prompt=
    export COLOR_BLACK=""
    export COLOR_DARKGRAY=""
    export COLOR_RED=""
    export COLOR_LIGHT_RED=""
    export COLOR_GREEN=""
    export COLOR_LIGHT_GREEN=""
    export COLOR_BROWN=""
    export COLOR_YELLOW=""
    export COLOR_BLUE=""
    export COLOR_LIGHT_BLUE=""
    export COLOR_PURPLE=""
    export COLOR_LIGHT_PURPLE=""
    export COLOR_CYAN=""
    export COLOR_LIGHT_CYAN=""
    export COLOR_GRAY=""
    export COLOR_WHITE=""
    export COLOR_NEUTRAL=""
  fi
fi

function fancy_prompt {
  return_code=$?
  return_code=$(printf "%3d" $return_code)
  if [ $return_code == 0 ]; then ret_color=$COLOR_LIGHT_BLUE; else ret_color=$COLOR_LIGHT_RED; fi
  gps1=$(__git_ps1 2> /dev/null)
  if [ $HOSTNAME == "antix1" ]; then newline="\n"; else newline=""; fi
  # Set your own prompt with color
  PS1="${debian_chroot:+($debian_chroot)}$COLOR_LIGHT_RED\u$COLOR_NEUTRAL@$COLOR_YELLOW\h:$ret_color$return_code$COLOR_LIGHT_GREEN:\w$COLOR_NEUTRAL$gps1$newline$COLOR_LIGHT_GREEN\$$COLOR_NEUTRAL "
}

if [ "$color_prompt" = yes ]; then
  PROMPT_COMMAND="fancy_prompt"
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *)
    ;;
esac

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

[ -d ~/.local/bin ] && PATH="~/.local/bin:${PATH}"
[ -d ~/bin ] && PATH="~/bin:${PATH}"

source $LOCAL_PWD/acd_func.sh

if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi
