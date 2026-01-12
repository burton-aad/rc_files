#! /bin/bash

# Use fzf to search through history
__ehc () {
  if
    [[ -n $1 ]]
  then
    builtin bind '"\er": redraw-current-line'
    builtin bind '"\e^": magic-space'
    READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${1}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
    READLINE_POINT=$(( READLINE_POINT + ${#1} ))
  else
    builtin bind '"\er":'
    builtin bind '"\e^":'
  fi
}
__fzf_history () {
  # fhe - repeat history edit
  # builtin history -a;
  # builtin history -c;
  # builtin history -r;
  __ehc $( history \
         | fzf +s --tac --bind ctrl-p:toggle-preview --preview="echo {}" \
               --preview-window=up:3:wrap:hidden --no-hscroll --exact \
         | sed -re 's/^\s*([0-9]+).*/!\1/')
}

export FZF_DEFAULT_OPTS='--height 40% --border --layout=reverse --inline-info --multi'

# Check space at begin of line. Use C-u C-r to not overwrite default C-r.
builtin bind -x '"\C-x1": "__fzf_history"';
builtin bind '"\C-u\C-r": "\C-x1\e^\er"'
