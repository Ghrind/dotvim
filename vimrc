execute pathogen#infect()
execute pathogen#helptags()

syntax on
set nu
set ruler
set backspace=2
set nocompatible

" Set tabs width, replace tabs by spaces and auto indent
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

:map <F2> :tabp<CR>
:map <F3> :tabn<CR>

:map <F5> :%s/\t/  /g<CR>
:map <F6> :red<CR>

" Remove trailing whitespaces
:map <F7> :%s/\s\+$//ge<CR>

" Copy paste into/from default clipboard
:map <F8> "+y
:map <F9> "+p

"Git branch
"function! GitBranch()
"    let branch = system("git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //'")
"    if branch != ''
"        return ' [BRANCH=' . substitute(branch, '\n', '', 'g') . ']'
"    en
"    return ''
"endfunction

" Status line
set statusline=%F%m%r%h%w\ [ENC=%{(&fenc==\"\"?&enc:&fenc)}]\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

" Color scheme
colorscheme mustang

" Highlight current line
"set cursorline
"hi CursorLine term=none cterm=none ctermbg=darkred

" gitgutter column color
highlight clear SignColumn
