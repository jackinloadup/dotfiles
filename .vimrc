"filetype indent plugin on

" enable syntax
syntax on


" Theme
set t_Co=256
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

set nomodeline
set nocompatible

set number
set list
set pastetoggle=<f2>
set autoindent
set smartindent

""""""""""""""""""""""""""""""""""
" User interface
""""""""""""""""""""""""""""""""""

" Set 7 lines to the curors - when moving vertical
set so=7

" search
set incsearch " instantly display search results
set ignorecase smartcase "Ignore case when searching

"display bracket match
set showmatch "Show matching bracets when text indicator is over them

""""""""""""""""""""""""""""""""""
" Editor
""""""""""""""""""""""""""""""""""

" Tab settings
set expandtab
set softtabstop=2
set shiftwidth=2

" Fold Settings
set foldmethod=syntax
set foldlevelstart=0

let javascript_fold=1

" autocomplete settings
imap <c-space> <c-x><c-o>
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS



if has("mouse")
  set mouse=a
endif

" toggle NERDtree
nmap <ESC>t :NERDTreeToggle<CR>

" forgot sudo.. no problem
cmap w!! %!sudo tee > /dev/null %

" sparkup settings
let g:sparkupArgs = '--no-last-newline --indent-spaces=2'

" highlight any text over 80 columns
highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" toggle text and mouse settings for easy copying
nmap <ESC>' :set list!<CR> :set number!<CR> :call ToggleMouse()<CR>

function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
    echo "Mouse usage disabled"
  else
    set mouse=a
    echo "Mouse usage enabled"
  endif
endfunction
