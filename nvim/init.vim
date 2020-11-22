
let mapleader = " "

"""" Plug stuff

" auto-install vim-plug                                                                                                                
if empty(glob('~/.config/nvim/autoload/plug.vim'))                                                                                    
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim                                                             
  autocmd VimEnter * PlugInstall                                                                                                      
endif                                                                                                                                 

call plug#begin('~/.config/nvim/plugged')   
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'morhetz/gruvbox'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
call plug#end()

"""" Actual custom
syntax on

" For fase search
set incsearch
set ignorecase
set smartcase

" Tab stuff
set expandtab
set smarttab
set shiftwidth=4
set ai
set si

" quality of life
set scrolloff=5
set number
set wildmenu
set wildmode=longest:list,full
set termguicolors
let g:asyncrun_open = 6
set hidden " no more warning on switching unsaved buffer
set guicursor=a:blinkon10
command W w " I keep using the large w

" set easymotion
" set textobj-entire
" set argtextobj

if executable('gopls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
        \ 'whitelist': ['go'],
        \ })
    autocmd BufWritePre *.go LspDocumentFormatSync
endif

" Color
autocmd vimenter * colorscheme gruvbox

" easymotion

let g:EasyMotion_smartcase = 1
map sh <Plug>(easymotion-bd-wl)
map sl <Plug>(easymotion-bd-wl)
map sj <Plug>(easymotion-j)
map sk <Plug>(easymotion-k)
map ss <Plug>(easymotion-s2)
map sw <Plug>(easymotion-bd-w)

" FZF
" bindings follows emacs binding
nmap <c-x><c-f> :Files<CR>
nmap <c-x>b :Buffers<CR>

"""" COC
nmap <leader>r :CocList tasks<CR>

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

"""" COMPETE STUFF

map <S-F2> :!g++ -std=c++11 % -o %:r.out<CR>
map <F2> :!g++ -std=c++11 -DDEBUG -Wfatal-errors % -o %:r.out<CR>

map <F3> :!./%:r.out < %:p:h/input<CR>
map <S-F3> :!./%:r.out < %:p:h/input \| diff %:p:h/answer - <CR>

map <F4> :!javac -Xlint:unchecked %<CR>
map <S-F4> :!java -classpath %:p:h Main < %:p:h/input<CR>

map <F5> :!stack runghc % < %:p:h/input <CR>
map <S-F5> :!stack ghc % -o %:r.out <CR>

