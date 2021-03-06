#! /bin/bash

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'

alias df='df -h'
alias du='du -h'

alias diff="diff -u"

alias e="emacs -nw"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -z "$HISTSIZE" ]; then
  # In case of no HISTSIZE, set it in gdb to get history.
  #alias gdb="HISTSIZE=1000000 gdb"
  gdb() { HISTSIZE=70000000; /usr/bin/gdb "$@"; }
  export -f gdb
fi

# fhe - repeat history edit
writecmd (){ perl -e 'ioctl STDOUT, 0x5412, $_ for split //, do{ chomp($_ = <>); $_ }' ; }
fhe() {
  ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac --bind ctrl-p:toggle-preview --preview="echo {}" --preview-window=up:3:wrap:hidden --no-hscroll -e | sed -re 's/^\s*[0-9]+\s*//' | writecmd
}

export FZF_DEFAULT_OPTS='--height 40% --border --layout=reverse --inline-info -m'

# Check space at begin of line. Use C-u C-r to not overwrite default C-r.
builtin bind -x '"\C-x1": "fhe"';
builtin bind '"\C-u\C-r": "\C-x1\e^\er"'
