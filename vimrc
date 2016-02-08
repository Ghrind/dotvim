" Enable the vim pathogen plugin manager
execute pathogen#infect()

" Disable folding for the markdown plugin
" https://github.com/plasticboy/vim-markdown#disable-folding
let g:vim_markdown_folding_disabled = 1

" Set the <Leader> key (works as a namespace for custom commands)
:let mapleader = ","

" Turn on syntax highlighting
syntax on

" Display line numbers
set nu

" Show a ruler in the status bar (not sure if this is really useful since the
" status bar is overriden
set ruler

" Make backspace work like any other editor (delete over line break,
" automatically-inserted indentation, or the place where insert mode started)
set backspace=2

" Disable the compatible mode (being compatible with the old vi)
set nocompatible

" Set tabs width, replace tabs by spaces and auto indent
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

" Allow to open up to 20 tabs
set tabpagemax=20

" Highlight all search pattern matches
:set hlsearch

" Status line
set statusline=%F%m%r%h%w\ [ENC=%{(&fenc==\"\"?&enc:&fenc)}]\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" Always show the status line
set laststatus=2

" Color scheme
colorscheme mustang

" gitgutter column color
nmap <Leader>hv <Plug>GitGutterPreviewHunk

" Font for gvim
set guifont=DejaVu\ Sans\ Mono\ 11

" :Split ls -la
" :Tab ls -la
" :! ls -la

" http://vim.wikia.com/wiki/Display_shell_commands'_output_on_Vim_window
" Run a shell command and open results in a horizontal split
command! -complete=file -nargs=+ Split call s:RunShellCommandInSplit(<q-args>)
function! s:RunShellCommandInSplit(cmdline)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1,a:cmdline)
  call setline(2,substitute(a:cmdline,'.','=','g'))
  execute 'silent $read !'.escape(a:cmdline,'%#')
  setlocal nomodifiable
  1
endfunction

" Copy of the above that opens results in a new tab.
command! -complete=file -nargs=+ Tab call s:RunShellCommandInTab(<q-args>)
function! s:RunShellCommandInTab(cmdline)
  tabnew
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1,a:cmdline)
  call setline(2,substitute(a:cmdline,'.','=','g'))
  execute 'silent $read !'.escape(a:cmdline,'%#')
  setlocal nomodifiable
  1
endfunction
" Issue a find command using regex and open results in a new tab.
command! -nargs=+ Find call s:RunShellCommandInTab('find . -iregex '.<q-args>)

" Search for visually selected text
" Hightlight some text and type // to search for it
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap // y/<C-R>"<CR>

" Remove help
:nmap <F1> :echo<CR>

" Run rubocop for the current file (open in new tab)
:map <F2> :Tab rubocop %<CR>

" Run ag for current word (open in new tab)
:map <F4> :Tab ag <cword><CR>

" Replace tabs by spaces
:map <F5> :%s/\t/  /g<CR>

" Redo key
:map <F6> :red<CR>

" Remove trailing whitespaces
:map <F7> :%s/\s\+$//ge<CR>

" Copy paste into/from default clipboard
:map <F8> "+y
:map <F9> "+p
