" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

set nobackup        " do not keep a backup file
if has('persistent_undo')
  set undofile      " keep an undo file (undo changes after closing)
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

set bg=dark
