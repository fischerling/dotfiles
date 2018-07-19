" set shell to a more POSIX compatible shell
if &shell =~# 'fish$'
    set shell=sh
endif

execute pathogen#infect()
filetype plugin indent on

set t_Co=256
syntax enable
set background=dark " dark | light "
colorscheme solarized
let g:solarized_termcolors=256

set cursorline
set colorcolumn=80

set showcmd		    " Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set hlsearch        " Highlight search results
set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		    " Hide buffers when they are abandoned
set number		    " Enable line numbers


set list
set listchars=tab:>.,trail:.
hi clear SpecialKey


" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "normal! g`\"" |
\ endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4
set autoindent
set smartindent


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2
" Format the status line
set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%1*%{&ff}%*            "file format
set statusline +=%2*%y%*                "file type
set statusline +=%1*\ %<%F%*            "full path
set statusline +=%3*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%1*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
" Color the status line
hi User1 ctermfg=245 ctermbg=235
hi User2 ctermfg=61  ctermbg=235
hi User3 ctermfg=160 ctermbg=235

""""""""""""""""""""""""""""""
" => Custom commands
""""""""""""""""""""""""""""""
" make 'W' write
command W w
command WQ wq
command Wq wq


""""""""""""""""""""""""""""""
" => Custom macros
""""""""""""""""""""""""""""""
let @a="ggVG" " select all
let @l=":set spell\n:set spelllang=de\n" " activate spellcheck for german
