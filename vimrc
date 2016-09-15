" case insensitive search
set ic

" Autoindent
set ai

"colo koehler " murphy, evening, slate, koehler, darkblue

" Line numbering
set nu

" Enhance comand-line completion
set wildmenu

" Always show current position
set ruler
"
" Always show the status line
set laststatus=2

" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l,%c
set statusline=\ %<%t\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" Highlight search results
set hlsearch

" Highlight dynamically as pattern is typed
set incsearch

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set matchtime=2

" Flash the screen instead of beeping
set visualbell

" Highlight current line
"set cursorline
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Start scrolling three lines before the horizontal window border
set scrolloff=4

" Use spaces instead of tabs
set expandtab

" One tab equals four spaces
set shiftwidth=2
set tabstop=2
set softtabstop=2

" Max width of text that is being inserted
set textwidth=80

" Scroll horizontally for long lines
set nowrap

" This should get best indenting for most common filetypes
filetype indent plugin on
set autoindent

" Allow saving of files as sudo when starting vim without sudo
cmap w!! w !sudo tee > /dev/null %

"""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and highlighting
"""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax on

" Show >80 columns
highlight OverLength ctermbg=red guibg=red
match OverLength /\%>80v.\+/

" Show >1 trailing whitespace (otherwise it's annoying as you type)
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\{2,\}$/

" Main color settings
" set guifont=Anonymous_Pro:h11
" set background=light
" colorscheme solarized

"""""""""""""""""""""""""""""""""""""""""""""""""
" File types and templates
"""""""""""""""""""""""""""""""""""""""""""""""""

" Pig language syntax highlighting
augroup filetypedetect 
  au BufNewFile,BufRead *.pig set filetype=pig syntax=pig 
augroup END 

" Enable file type detection
filetype on

" Treat .phpt files as .php
autocmd BufNewFile,BufRead *.phpt set filetype=php
" Treat .json files as .js
autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript

autocmd bufnewfile *.php :0r ~/.vim/templates/template.php
autocmd bufnewfile *.js :0r ~/.vim/templates/template.js

" Look for tags file
"set tags=tags;/

"""""""""""""""""""""""""""""""""""""""""""""""""
" Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
      return 'PASTE MODE  '
    en
    return ''
endfunction


"map <F12> <C-W>+
"map <F11> <C-W>-
map <F9> <C-W><
map <F10> <C-W>>
map + <C-W>v
map - <C-W><C-W>

" From jbinney, switching between tabs and opening window for lookup
function MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

"map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
"map <C-m> :call MoveToNextTab()<CR><C-w>H
"map <C-n> :call MoveToPrevTab()<CR><C-w>H

" Map C-q directly to closing window
"map <C-q> <C-w><C-q>

" Switch between tabs
map <C-h> :tabp<CR>
map <C-l> :tabn<CR>
map <C-n> :tabnew 

"""""""""""""""""""""""""""""""""""""""""""""""""
" Note: Partly copied from ~jsu, ~jlindamood, http://amix.dk/vim/vimrc.html
" " (v5.0), and https://github.com/mathiasbynens/dotfiles/blob/master/.vimrc
