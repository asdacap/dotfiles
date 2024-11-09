
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
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

" LSP Support
Plug 'neovim/nvim-lspconfig'
" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'

Plug 'nvim-lua/plenary.nvim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-neotest/nvim-nio'
Plug 'nvim-neotest/neotest'
Plug 'nvim-neotest/neotest-go'

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

vim.keymap.set('n', '<leader>xf', ':Files<CR>')
vim.keymap.set('n', '<leader>b', ':Buffers<CR>')

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

-- Custom window navigation
vim.keymap.set('n', '<leader>w', '<c-w><c-w>')
vim.keymap.set('n', '<leader>cc', ':e ~/.config/nvim/init.lua<cr>')

-- LSP config
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})

  vim.keymap.set('n', '<m-space>', vim.lsp.buf.code_action)
  vim.keymap.set('n', '<m-cr>', vim.lsp.buf.code_action)
  vim.keymap.set('n', '<leader>r', vim.lsp.codelens.run)


  -- Enable codelens refresh
  if client.server_capabilities.codeLensProvider then
      vim.api.nvim_create_autocmd({"BufEnter", "InsertLeave"}, {
          buffer = bufnr,
          callback = vim.lsp.codelens.refresh,
      })
      vim.lsp.codelens.refresh()
  end
end)

local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.gopls.setup {
   settings = {
        gopls = {
            codelenses = {
                generate = true,  -- Enable code lens for `go generate`
                gc_details = true,  -- Enable code lens for garbage collection optimization details
                regenerate_cgo = true,  -- Enable code lens for `go mod tidy` to update dependencies
                test = true,  -- Enable code lens for testing features (including running tests)
                tidy = true,  -- Enable code lens for `go mod tidy`
            },
        },
    },
}
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}

-- Telesdorep
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

require("neotest").setup({
  adapters = {
    require("neotest-go")({
      experimental = {
        test_table = false,
      },
      args = { "-count=1", "-timeout=60s" }
    })
  }
})


local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({select = true}),
    ['<Tab>'] = cmp.mapping.confirm({select = false}),
    -- ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
  }),
})
