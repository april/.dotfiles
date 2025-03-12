" Options
set nocompatible         " don't make vim behave like vi
set bs=indent,start      " allow backspacing over everything in insert mode (except \n & \t)
set viminfo='20,\"50     " read/write a .viminfo file, don't store more than 50 lines of registers
set history=50           " keep 50 lines of command line history
set ruler                " show the cursor position all the time
set ai                   " autoindent what I've indented myself
set expandtab            " soft tabs
set shiftwidth=2         " when using >, indent as much as my tabstop
set tabstop=2            " indent 2 spaces
set hlsearch             " highlight last highlight
set nocindent            " turn off c indenting
set ruler                " show me where the cursor is
set rulerformat=%l/%L(%p%%),%c " a better ruler
set showmatch            " show matching brackets 
set showmode             " display mode (INSERT/REPLACE/etc.)
set ignorecase           " be case insensitive on searches
set smartcase            " but do be case sensitive on searches with capital letters
set shortmess=lnrxIT     " get rid of splash screens
set matchtime=3          " only show matching perens for .3 seconds, not .5
set noinsertmode         " start in command mode
set cpoptions=$          " use the $ symbol on cw
set clipboard=exclude:.* " ignore all X extensions

" Keymappings
                         " keeps me from fat-fingering :x and :q
map :X :x
map :Q :q
                         " F1 is too close to ESC, and I use :h anyways.
map <F1> <ESC>
map! <F1> <ESC>

" Disable xterm-color
if &term == 'xterm-color'
  set term=xterm
endif

if has("terminfo")
  set t_Co=8
  set t_Sf=[3%p1%dm
  set t_Sb=[4%p1%dm
else
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

" Syntax highlighting
syntax on
set background=dark
set termguicolors
colorscheme toast

autocmd BufRead *.c,*.h set nocindent " vim just loves cindent no matter what
autocmd FileType changelog set textwidth=0 " vim doesn't know best
autocmd FileType mail call Mail_setup() " perfect for mutt

" When vim is launched from mutt
function Mail_setup()
  set textwidth=72
  set noai
	:silent! %s/> \{2,\}/> /e
	:silent! %s/\(> *\n\)\{2,\}/> \r/eg
	:silent! %s//\'/eg
	:silent! %s///eg
	:silent! %s///eg
	:silent! %s/\n> \n> __\._,_\.___\_.*__,_\._,___\s\s//eg
	:let @/=""
	:1
endfunction

" Make comments bolded, light blue.  Super easy to read against a black bg.
:highlight Comment term=bold cterm=bold ctermfg=6
