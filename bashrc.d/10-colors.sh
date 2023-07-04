#! /bin/bash

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)

  # see man 4 console_codes
  # \[ and \] are used in bash prompt (see man bash PROMPTING) to start and
  # end a sequence character so size of prompt is correctly computed.
  export COLOR_BLACK="\[\033[0;90m\]"
  export COLOR_DARKGRAY="\[\033[1;90m\]"
  export COLOR_RED="\[\033[0;91m\]"
  export COLOR_LIGHT_RED="\[\033[1;91m\]"
  export COLOR_GREEN="\[\033[0;92m\]"
  export COLOR_LIGHT_GREEN="\[\033[1;92m\]"
  export COLOR_BROWN="\[\033[0;93m\]"
  export COLOR_YELLOW="\[\033[1;93m\]"
  export COLOR_BLUE="\[\033[0;94m\]"
  export COLOR_LIGHT_BLUE="\[\033[1;94m\]"
  export COLOR_PURPLE="\[\033[0;95m\]"
  export COLOR_LIGHT_PURPLE="\[\033[1;95m\]"
  export COLOR_CYAN="\[\033[0;96m\]"
  export COLOR_LIGHT_CYAN="\[\033[1;96m\]"
  export COLOR_GRAY="\[\033[0;97m\]"
  export COLOR_WHITE="\[\033[1;97m\]"
  export COLOR_NEUTRAL="\[\033[0m\]"
else
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
