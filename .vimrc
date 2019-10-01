"""""""""""""""""""""
"""" COMPETE STUFF

map <S-F2> :!g++ -std=c++11 % -o %:r.out<CR>
map <F2> :!g++ -std=c++11 -DDEBUG -Wfatal-errors % -o %:r.out<CR>

map <F3> :!./%:r.out < %:p:h/input<CR>
map <S-F3> :!./%:r.out < %:p:h/input \| diff %:p:h/answer - <CR>

map <F4> :!javac -Xlint:unchecked %<CR>
map <S-F4> :!java -classpath %:p:h Main < %:p:h/input<CR>

map <F5> :!stack runghc % < %:p:h/input <CR>
map <S-F5> :!stack ghc % -o %:r.out <CR>

syntax on
set expandtab
set smarttab
set shiftwidth=4
set ai
set si


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              START Vundle                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
"Plugin 'scrooloose/nerdtree'
"Plugin 'scrooloose/nerdcommenter'
"Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
"Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
"Plugin 'vim-syntastic/syntastic'
Plugin 'mattn/emmet-vim'
"Plugin 'pangloss/vim-javascript'
"Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'valloric/youcompleteme'
Plugin 'eagletmt/neco-ghc'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                END Vundle                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Youcomplet
let g:ycm_semantic_triggers = {'haskell' : ['.']}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               START Custom                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set relativenumber

" Solarized theme
syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

set scrolloff=5

set wildmenu
