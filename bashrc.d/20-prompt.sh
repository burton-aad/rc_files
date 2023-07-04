#! /bin/bash

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

PS1_NEWLINE=""
[[ $HOSTNAME == "antix1" || $TERM =~ "eterm" ]] && PS1_NEWLINE="\n"

function fancy_prompt {
  return_code=$?
  return_code=$(printf "%3d" $return_code)
  if [ $return_code == 0 ]; then ret_color=$COLOR_LIGHT_BLUE; else ret_color=$COLOR_LIGHT_RED; fi
  gps1=$(__git_ps1 2> /dev/null)
  # Set your own prompt with color
  PS1=""
  [ "$VIRTUAL_ENV" ] && PS1+="($(basename $VIRTUAL_ENV)) " # python virtual env
  PS1+="${debian_chroot:+($debian_chroot)}" # chroot
  PS1+="$COLOR_LIGHT_RED\u"                 # username
  PS1+="$COLOR_NEUTRAL@"                    # separator
  PS1+="$COLOR_YELLOW\h:"                   # hostname
  PS1+="$ret_color$return_code"             # return code from last command
  PS1+="$COLOR_LIGHT_GREEN:\w"              # working diretcory
  [ $gps1 ] && PS1+="$COLOR_NEUTRAL$gps1"   # git branch
  PS1+="$PS1_NEWLINE$COLOR_LIGHT_GREEN\$$COLOR_NEUTRAL " # end of prompt
}

PROMPT_COMMAND="fancy_prompt"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
    PROMPT_COMMAND="$PROMPT_COMMAND;echo -ne \"\033]0;\${debian_chroot:+(\$debian_chroot)}\${USER}@\${HOSTNAME}: \${PWD/\$HOME/\~}\007\""
    ;;
  *)
    ;;
esac
