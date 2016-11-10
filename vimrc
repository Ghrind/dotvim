" Enable the vim pathogen plugin manager
execute pathogen#infect()

" Powerline font for airline
let g:airline_powerline_fonts = 1

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
set hlsearch
" Clear highlighted search
nmap <silent> ,/ :nohlsearch<CR>

" show search matches as you type
set incsearch

" change the terminal's title
set title

" don't beep
set visualbell
set noerrorbells

" Don't bother me with swap files
set nobackup
set noswapfile

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

" Issue an ag command
command! -nargs=+ S call s:RunShellCommandInTab('ag "'.<q-args>.'"')

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

" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction

" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR>

" CTRL-P opens in new tab by default
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
