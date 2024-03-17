
-- Plug stuff
vim.cmd([[
if empty(glob('~/.config/nvim/autoload/plug.vim'))                                                                                    
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim                                                             
  autocmd VimEnter * PlugInstall                                                                                                      
endif                                                                                                                                 

call plug#begin('~/.config/nvim/plugged')   
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'cappyzawa/starlark.vim'

" LSP Support
Plug 'neovim/nvim-lspconfig'
" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'

Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}
call plug#end()
]])

vim.cmd("syntax on")

vim.g.mapleader = " "

-- Search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Tab stuff
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.ai = true
vim.opt.si = true

-- Color
vim.cmd("autocmd vimenter * colorscheme gruvbox")

-- quality of life
vim.opt.scrolloff = 5
vim.opt.relativenumber = true
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest:list", "full" }

vim.opt.termguicolors = true
vim.opt.guicursor = "a:blinkon10"

-- FZF
-- bindings follows emacs binding
vim.keymap.set('n', '<c-x><c-f>', ':Files<CR>')
vim.keymap.set('n', '<c-x>b', ':Buffers<CR>')

-- Some emacs stuff that I got used to
vim.keymap.set('n', '<c-a>', 'I')
vim.keymap.set('n', '<c-e>', 'A')
vim.keymap.set('i', '<c-a>', '<c-o>$')
vim.keymap.set('i', '<c-e>', '<c-o>^')
vim.keymap.set('i', '<m-b>', '<c-o>b')
vim.keymap.set('i', '<m-f>', '<c-o>w')
vim.keymap.set('i', '<m-d>', '<c-o>dw')
vim.keymap.set('n', '<c-k>', 'd$')
vim.keymap.set('i', '<c-k>', '<c-o>d$')

-- LSP config
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})

  vim.keymap.set('n', '<m-space>', vim.lsp.buf.code_action)
end)

local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}


local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
  }),
})
