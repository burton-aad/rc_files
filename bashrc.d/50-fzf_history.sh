#! /bin/bash

# Use fzf to search through history
writecmd (){ perl -e 'ioctl STDOUT, 0x5412, $_ for split //, do{ chomp($_ = <>); $_ }' ; }
fhe() {
  # fhe - repeat history edit
  ([ -n "$ZSH_NAME" ] && fc -l 1 || history) \
    | fzf +s --tac --bind ctrl-p:toggle-preview --preview="echo {}" \
          --preview-window=up:3:wrap:hidden --no-hscroll --exact \
    | sed -re 's/^\s*[0-9]+\s*//' | writecmd
}

export FZF_DEFAULT_OPTS='--height 40% --border --layout=reverse --inline-info --multi'

# Check space at begin of line. Use C-u C-r to not overwrite default C-r.
builtin bind -x '"\C-x1": "fhe"';
builtin bind '"\C-u\C-r": "\C-x1\e^\er"'
